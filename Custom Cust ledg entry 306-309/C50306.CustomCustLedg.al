codeunit 50306 CustomCustLedgerEntry
{
    var
        SLSingleInstanceCU: Codeunit "SL Single Instance Codeunit";

    //To Transfer data from the customer ledger to custom table
    procedure TransferDataFun()
    var
        CustledEntry: Record "Cust. Ledger Entry";
        NewEntries: Record "Custom CustLed Entry";
        CounterInt: Integer;
        TotalCount: Integer;
        ProgressWindow: Dialog;
    begin
        CustledEntry.Reset();
        if CustledEntry.FindSet then begin
            if not NewEntries.Get(CustledEntry."Entry No.") then begin
                CounterInt := 0;
                TotalCount := CustledEntry.Count;
                ProgressWindow.Open('Processing...\Total: #1##################\Current: #2##################');
                ProgressWindow.Update(1, CustledEntry.Count);
                repeat
                    CounterInt += 1;
                    ProgressWindow.Update(2, CounterInt);
                    NewEntries.Init();
                    NewEntries.TransferFields(CustledEntry);
                    NewEntries.Insert();
                until CustledEntry.Next = 0;
                ProgressWindow.Close();
            end
            else
                Error('Data already exist with the same entry no');
        end;
    end;

    //To calculate the running balance and invoice balance for all the entries in the custom table
    procedure RunningBalanceFun()
    var
        NewCustomers: Record "Custom CustLed Entry";
        NewCustomers1: Record "Custom CustLed Entry";
        TempAmountRunning: Decimal;
        TempAmountInvoice: Decimal;
    begin
        NewCustomers.Reset();
        NewCustomers.SetCurrentKey("Posting Date");
        if NewCustomers.FindSet() then begin
            repeat
                NewCustomers1.SetAutoCalcFields("Remaining Amount");
                NewCustomers1.SetAutoCalcFields(Amount);
                NewCustomers1.SetCurrentKey("Posting Date");
                NewCustomers1.SetLoadFields("Entry No.", "Customer No.", Amount, "Remaining Amount", "Invoice Balance", "Posting Date", "Document Type");
                NewCustomers1.SetFilter("Posting Date", '<=%1', NewCustomers."Posting Date");
                NewCustomers1.SetRange("Customer No.", NewCustomers."Customer No.");
                TempAmountRunning := 0;
                TempAmountInvoice := 0;
                if NewCustomers1.FindSet() then
                    repeat
                        TempAmountRunning += NewCustomers1.Amount;
                        if (NewCustomers1."Document Type" = NewCustomers1."Document Type"::Invoice) or (NewCustomers1."Document Type" = NewCustomers1."Document Type"::"Credit Memo") then
                            TempAmountInvoice += NewCustomers1."Remaining Amount";
                        if NewCustomers1."Entry No." = NewCustomers."Entry No." then
                            break;
                    until NewCustomers1.Next = 0;
                NewCustomers."Running Balance" := TempAmountRunning;
                NewCustomers."Invoice Balance" := TempAmountInvoice;
                NewCustomers.Modify(true);
            until NewCustomers.Next() = 0;
        end;
    end;

    //To calculate balances for the new entries
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnAfterCustLedgEntryInsertInclPreviewMode, '', false, false)]
    local procedure OnAfterCustLedgEntryInsertInclPreviewMode(var Sender: Codeunit "Gen. Jnl.-Post Line"; var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line"; DtldLedgEntryInserted: Boolean);
    begin
        NewInsertionCalculation(CustLedgerEntry)
    end;

    //To calculate balances for reversed entries
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", OnReverseCustLedgEntryOnAfterInsertCustLedgEntry, '', false, false)]
    local procedure "Gen. Jnl.-Post Reverse_OnReverseCustLedgEntryOnAfterInsertCustLedgEntry"(var NewCustLedgerEntry: Record "Cust. Ledger Entry"; CustLedgerEntry: Record "Cust. Ledger Entry"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    begin
        SLSingleInstanceCU.InsertTempCLE(NewCustLedgerEntry."Entry No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", OnReverseGLEntryOnAfterReverseCustLedgEntry, '', false, false)]
    local procedure "Gen. Jnl.-Post Reverse_OnReverseGLEntryOnAfterReverseCustLedgEntry"(var TempCustLedgerEntry: Record "Cust. Ledger Entry" temporary; var GLEntry: Record "G/L Entry"; GLEntry2: Record "G/L Entry")
    var
        CLERec: Record "Cust. Ledger Entry";
    begin
        IF NOT CLERec.Get(SLSingleInstanceCU.ReturnCLE()) then
            exit;
        NewInsertionCalculation(CLERec)
    end;

    //Apply entries
    //OnBefore apply get the applied entries and stores in a list
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CustEntry-Apply Posted Entries", OnBeforePostApplyCustLedgEntry, '', false, false)]
    local procedure "CustEntry-Apply Posted Entries_OnBeforePostApplyCustLedgEntry"(var GenJournalLine: Record "Gen. Journal Line"; CustLedgerEntry: Record "Cust. Ledger Entry"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; ApplyUnapplyParameters: Record "Apply Unapply Parameters" temporary)
    begin
        SLSingleInstanceCU.ClearList();
        SLSingleInstanceCU.FindAppliednEnties(CustLedgerEntry, true);
    end;

    //Modify the invoice balance for and after entry no if it is not present in onbefore list
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CustEntry-Apply Posted Entries", OnAfterPostApplyCustLedgEntry, '', false, false)]
    local procedure "CustEntry-Apply Posted Entries_OnAfterPostApplyCustLedgEntry"(GenJournalLine: Record "Gen. Journal Line"; CustLedgerEntry: Record "Cust. Ledger Entry"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    begin
        CalculateModifiedBalances(CustLedgerEntry."Entry No.");
        SLSingleInstanceCU.FindAppliednEnties(CustLedgerEntry, false);
    end;

    //Unapply entries
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CustEntry-Apply Posted Entries", OnBeforeUnApplyCustomer, '', false, false)]
    local procedure "CustEntry-Apply Posted Entries_OnBeforeUnApplyCustomer"(DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; var IsHandled: Boolean)
    var
        CLERec: Record "Cust. Ledger Entry";
    begin
        SLSingleInstanceCU.CheckCustLedgEntryToUnapply(DtldCustLedgEntry."Cust. Ledger Entry No.", DtldCustLedgEntry);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CustEntry-Apply Posted Entries", OnAfterUnApplyCustomer, '', false, false)]
    local procedure "CustEntry-Apply Posted Entries_OnAfterUnApplyCustomer"(DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry")
    var
        EntryTemp_Int: Integer;
    begin
        EntryTemp_Int := DtldCustLedgEntry."Cust. Ledger Entry No.";
        CalculateModifiedBalances(EntryTemp_Int);
        SLSingleInstanceCU.AfterUnappliedEntried(DtldCustLedgEntry."Cust. Ledger Entry No.");
    end;

    //To modify the invoice balances after unapply, apply and new insertion
    procedure CalculateModifiedBalances(EntryTemp_Int: Integer)
    var
        CustLedger_Rec: Record "Cust. Ledger Entry";
        CustomRecord: Record "Custom CustLed Entry";
        CustomRecord1: Record "Custom CustLed Entry";
        AmountInv: Decimal;
    begin
        // CustomRecord1.Get(EntryTemp_Int);
        CustLedger_Rec.Get(EntryTemp_Int);
        CustLedger_Rec.CalcFields("Remaining Amount");
        CustomRecord1.get(EntryTemp_Int);
        CustomRecord.Reset();
        CustomRecord.SetCurrentKey("Posting Date");
        CustomRecord.SetFilter("Posting Date", '<=%1', CustLedger_Rec."Posting Date");
        CustomRecord.SetFilter("Entry No.", '<%1', EntryTemp_Int);
        CustomRecord.SetRange("Customer No.", CustLedger_Rec."Customer No.");
        CustomRecord.CalcFields("Remaining Amount", Amount);
        if CustomRecord.FindLast() then
            AmountInv := CustomRecord."Invoice Balance";

        CustomRecord.Reset();
        if CustomRecord.Get(EntryTemp_Int) then begin
            if (CustLedger_Rec."Document Type" = CustLedger_Rec."Document Type"::Invoice) or
             (CustLedger_Rec."Document Type" = CustLedger_Rec."Document Type"::"Credit Memo") then
                AmountInv += CustLedger_Rec."Remaining Amount";
            CustomRecord."Invoice Balance" := AmountInv;
            CustomRecord.Modify();
        end;

        CustLedger_Rec.Reset();
        CustomRecord.Reset();
        CustLedger_Rec.SetCurrentKey("Posting Date");
        CustLedger_Rec.SetFilter("Posting Date", '>=%1', CustomRecord1."Posting Date");
        CustLedger_Rec.SetRange("Customer No.", CustomRecord1."Customer No.");
        if CustLedger_Rec.FindSet() then begin
            repeat
                CustLedger_Rec.CalcFields("Remaining Amount", Amount);
                if not ((CustLedger_Rec."Posting Date" = CustomRecord1."Posting Date") and
                (CustLedger_Rec."Entry No." <= CustomRecord1."Entry No.")) then
                    if (CustLedger_Rec."Document Type" = CustLedger_Rec."Document Type"::Invoice) or
                    (CustLedger_Rec."Document Type" = CustLedger_Rec."Document Type"::"Credit Memo") then
                        AmountInv := AmountInv + CustLedger_Rec."Remaining Amount";
                if CustomRecord.Get(CustLedger_Rec."Entry No.") then begin
                    CustomRecord."Invoice Balance" := AmountInv;
                    CustomRecord.Modify(true);
                end;
            until CustLedger_Rec.Next = 0;
        end;
    end;



    //Calculating the running balance for the new insertions
    procedure NewInsertionCalculation(var CustLedgerEntry: Record "Cust. Ledger Entry")
    var
        CustomRecord: Record "Custom CustLed Entry";
        CustomRecord1: Record "Custom CustLed Entry";
        AmountVar: Decimal;
        AmountInv: Decimal;
    begin
        CustLedgerEntry.CalcFields(Amount, "Remaining Amount");
        // Find Last Custom Entry.
        CustomRecord.Reset();
        CustomRecord.SetCurrentKey("Posting Date");
        CustomRecord.SetFilter("Posting Date", '<=%1', CustLedgerEntry."Posting Date");
        CustomRecord.SetFilter("Entry No.", '<%1', CustLedgerEntry."Entry No.");
        CustomRecord.SetRange("Customer No.", CustLedgerEntry."Customer No.");
        if CustomRecord.FindLast() then begin
            AmountVar := CustomRecord."Running Balance";
            AmountInv := CustomRecord."Invoice Balance";
        end;

        //Inserting the new record into custom table with running balace
        CustomRecord1.Reset();
        CustomRecord1.Init();
        CustomRecord1.TransferFields(CustLedgerEntry);
        CustomRecord1."Running Balance" := AmountVar + CustLedgerEntry.Amount;
        if CustLedgerEntry."Reversed Entry No." = 0 then begin
            if (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Invoice) or (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::"Credit Memo") then
                AmountInv += CustLedgerEntry."Remaining Amount";
        end;
        CustomRecord1."Invoice Balance" := AmountInv;
        CustomRecord1.Insert();

        //To modify running balance for the next records
        CustomRecord1.Reset();
        CustomRecord1.SetFilter("Posting Date", '>%1', CustLedgerEntry."Posting Date");
        CustomRecord1.SetRange("Customer No.", CustLedgerEntry."Customer No.");
        CustomRecord1.CalcFields("Remaining Amount", Amount);
        if CustomRecord1.FindSet() then
            repeat
                CustomRecord1."Running Balance" += CustLedgerEntry.Amount;
                CustomRecord1.Modify(true);
            until CustomRecord1.Next = 0;

        //To modify Incoice balance for the next records
        if CustLedgerEntry."Reversed Entry No." = 0 then begin
            CustomRecord1.Reset();
            CustomRecord1.SetFilter("Posting Date", '>%1', CustLedgerEntry."Posting Date");
            CustomRecord1.SetRange("Customer No.", CustLedgerEntry."Customer No.");
            CustomRecord1.CalcFields("Remaining Amount", Amount);
            if CustomRecord1.FindSet() then
                repeat
                    if (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Invoice) or (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::"Credit Memo") then
                        CustomRecord1."Invoice Balance" += CustLedgerEntry."Remaining Amount";
                    CustomRecord1.Modify(true);
                until CustomRecord1.Next = 0;
        end
        else begin
            //New Reversed
            CalculateModifiedBalances(CustLedgerEntry."Reversed Entry No.");
        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", OnAfterModifyEvent, '', false, false)]
    local procedure OnAfterModifyEvent(VAR Rec: Record "Cust. Ledger Entry"; RunTrigger: Boolean)
    var
        CustomRecord: Record "Custom CustLed Entry";
    begin
        CustomRecord.Reset();
        if CustomRecord.get(Rec."Entry No.") then begin
            CustomRecord.TransferFields(Rec);
            CustomRecord.Modify(true);
        end;
    end;

}