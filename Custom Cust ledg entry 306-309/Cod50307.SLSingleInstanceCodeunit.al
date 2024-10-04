codeunit 50307 "SL Single Instance Codeunit"
{
    SingleInstance = true;

    var
        TmpCLE: Record "Cust. Ledger Entry" temporary;
        AppliedCustLedgerEntry_gRec: Record "Cust. Ledger Entry";
        EntryList: List of [Integer];
        NoApplicationEntryErr: Label 'Cust. Ledger Entry No. %1 does not have an application entry.';
        CannotUnapplyInReversalErr: Label 'You cannot unapply Cust. Ledger Entry No. %1 because the entry is part of a reversal.';
        DetailedCustLedgEntry2: Record "Detailed Cust. Ledg. Entry";
        PostingDate: Date;
        Cust: Record Customer;
        DocNo: Code[20];
        TmpDtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry" temporary;
        AppliedCLE: Record "Cust. Ledger Entry";

    procedure InsertTempCLE(var CLEEntryNo: Integer)
    var
        myInt: Integer;
    begin
        TmpCLE.Reset();
        TmpCLE.DeleteAll();

        IF NOT TmpCLE.Get(CLEEntryNo) then begin
            TmpCLE.Init();
            TmpCLE."Entry No." := CLEEntryNo;
            TmpCLE.Insert(true);
        end;
    end;

    procedure ReturnCLE(): Integer
    var
        myInt: Integer;
    begin
        TmpCLE.Reset();
        If TmpCLE.FindFirst() then
            exit(TmpCLE."Entry No.");
        TmpCLE.DeleteAll();
    end;



    //UnApplied Entries
    procedure ClearFilters_Fun()
    begin
        TmpDtldCustLedgEntry.Reset();
        TmpDtldCustLedgEntry.DeleteAll();
    end;

    procedure CheckReversal(CustLedgEntryNo: Integer)
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgEntry.Get(CustLedgEntryNo);
        if CustLedgEntry.Reversed then
            Error(CannotUnapplyInReversalErr, CustLedgEntryNo);
    end;

    procedure FindLastApplEntry(CustLedgEntryNo: Integer): Integer
    var
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        ApplicationEntryNo: Integer;
    begin
        DtldCustLedgEntry.SetCurrentKey("Cust. Ledger Entry No.", "Entry Type");
        DtldCustLedgEntry.SetRange("Cust. Ledger Entry No.", CustLedgEntryNo);
        DtldCustLedgEntry.SetRange("Entry Type", DtldCustLedgEntry."Entry Type"::Application);
        DtldCustLedgEntry.SetRange(Unapplied, false);
        ApplicationEntryNo := 0;
        if DtldCustLedgEntry.Find('-') then
            repeat
                if DtldCustLedgEntry."Entry No." > ApplicationEntryNo then
                    ApplicationEntryNo := DtldCustLedgEntry."Entry No.";
            until DtldCustLedgEntry.Next() = 0;
        exit(ApplicationEntryNo);
    end;

    procedure CheckCustLedgEntryToUnapply(CustLedgEntryNo: Integer; var DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry")
    var
        ApplicationEntryNo: Integer;
        CustomCustCU: Codeunit CustomCustLedgerEntry;
    begin
        ClearFilters_Fun();
        CheckReversal(CustLedgEntryNo);
        ApplicationEntryNo := FindLastApplEntry(CustLedgEntryNo);
        if ApplicationEntryNo = 0 then
            Error(NoApplicationEntryErr, CustLedgEntryNo);
        DetailedCustLedgEntry.Get(ApplicationEntryNo);


        DetailedCustLedgEntry.TESTFIELD("Entry Type", DetailedCustLedgEntry."Entry Type"::Application);
        DetailedCustLedgEntry.TESTFIELD(Unapplied, FALSE);

        DetailedCustLedgEntry2.GET(DetailedCustLedgEntry."Entry No.");
        CustLedgEntryNo := DetailedCustLedgEntry2."Cust. Ledger Entry No.";
        PostingDate := DetailedCustLedgEntry2."Posting Date";
        DocNo := DetailedCustLedgEntry2."Document No.";
        Cust.GET(DetailedCustLedgEntry2."Customer No.");

        IF DetailedCustLedgEntry2."Transaction No." = 0 THEN BEGIN
            DetailedCustLedgEntry.SETCURRENTKEY("Application No.", "Customer No.", "Entry Type");
            DetailedCustLedgEntry.SETRANGE("Application No.", DetailedCustLedgEntry2."Application No.");
        END ELSE BEGIN
            DetailedCustLedgEntry.SETCURRENTKEY("Transaction No.", "Customer No.", "Entry Type");
            DetailedCustLedgEntry.SETRANGE("Transaction No.", DetailedCustLedgEntry2."Transaction No.");
        END;
        DetailedCustLedgEntry.SETRANGE("Customer No.", DetailedCustLedgEntry2."Customer No.");
        TmpDtldCustLedgEntry.DELETEALL;
        IF DetailedCustLedgEntry.FINDSET THEN
            REPEAT
                IF (DetailedCustLedgEntry."Entry Type" <> DetailedCustLedgEntry."Entry Type"::"Initial Entry") AND
                   NOT DetailedCustLedgEntry.Unapplied
                THEN BEGIN
                    TmpDtldCustLedgEntry := DetailedCustLedgEntry;
                    TmpDtldCustLedgEntry.INSERT;
                END;
            UNTIL DetailedCustLedgEntry.NEXT = 0;
    end;

    procedure AfterUnappliedEntried(CustLedgEntryNo: Integer)
    var
        CustomCustCU: Codeunit CustomCustLedgerEntry;
    begin
        TmpDtldCustLedgEntry.SETFILTER("Entry No.", '<>%1', CustLedgEntryNo);
        TmpDtldCustLedgEntry.SetRange("Cust. Ledger Entry No.");
        if TmpDtldCustLedgEntry.FindSet() then
            repeat begin
                CustomCustCU.CalculateModifiedBalances(TmpDtldCustLedgEntry."Cust. Ledger Entry No.");
            end until TmpDtldCustLedgEntry.Next() = 0;

    end;


    //Applied entries
    procedure ClearList()
    begin
        Clear(EntryList);
    end;

    procedure ClearAppliedEntriesFnc()

    begin
        AppliedCustLedgerEntry_gRec.RESET;
    end;

    procedure FindAppliednEnties(CreateCustLedgEntry: Record "Cust. Ledger Entry"; TempBool: boolean);
    var
        CustomCustCU: Codeunit CustomCustLedgerEntry;
        DtldCustLedgEntry1: Record "Detailed Cust. Ledg. Entry";
        DtldCustLedgEntry2: Record "Detailed Cust. Ledg. Entry";
    begin
        ClearAppliedEntriesFnc();
        DtldCustLedgEntry1.SETCURRENTKEY("Cust. Ledger Entry No.");
        DtldCustLedgEntry1.SETRANGE("Cust. Ledger Entry No.", CreateCustLedgEntry."Entry No.");
        DtldCustLedgEntry1.SETRANGE(Unapplied, FALSE);
        IF DtldCustLedgEntry1.FIND('-') THEN
            REPEAT
                IF DtldCustLedgEntry1."Cust. Ledger Entry No." =
                   DtldCustLedgEntry1."Applied Cust. Ledger Entry No."
                THEN BEGIN
                    DtldCustLedgEntry2.INIT;
                    DtldCustLedgEntry2.SETCURRENTKEY("Applied Cust. Ledger Entry No.", "Entry Type");
                    DtldCustLedgEntry2.SETRANGE(
                      "Applied Cust. Ledger Entry No.", DtldCustLedgEntry1."Applied Cust. Ledger Entry No.");
                    DtldCustLedgEntry2.SETRANGE("Entry Type", DtldCustLedgEntry2."Entry Type"::Application);
                    DtldCustLedgEntry2.SETRANGE(Unapplied, FALSE);
                    IF DtldCustLedgEntry2.FIND('-') THEN
                        REPEAT
                            IF DtldCustLedgEntry2."Cust. Ledger Entry No." <>
                               DtldCustLedgEntry2."Applied Cust. Ledger Entry No."
                            THEN BEGIN
                                AppliedCustLedgerEntry_gRec.SETCURRENTKEY("Entry No.");
                                AppliedCustLedgerEntry_gRec.SETRANGE("Entry No.", DtldCustLedgEntry2."Cust. Ledger Entry No.");
                                IF AppliedCustLedgerEntry_gRec.FIND('-') THEN
                                    AppliedCustLedgerEntry_gRec.MARK(TRUE);
                            END;
                        UNTIL DtldCustLedgEntry2.NEXT = 0;
                END ELSE BEGIN
                    AppliedCustLedgerEntry_gRec.SETCURRENTKEY("Entry No.");
                    AppliedCustLedgerEntry_gRec.SETRANGE("Entry No.", DtldCustLedgEntry1."Applied Cust. Ledger Entry No.");
                    IF AppliedCustLedgerEntry_gRec.FIND('-') THEN
                        AppliedCustLedgerEntry_gRec.MARK(TRUE);
                END;
            UNTIL DtldCustLedgEntry1.NEXT = 0;

        AppliedCustLedgerEntry_gRec.SETCURRENTKEY("Entry No.");
        AppliedCustLedgerEntry_gRec.SETRANGE("Entry No.");
        AppliedCustLedgerEntry_gRec.SETCURRENTKEY("Closed by Entry No.");
        AppliedCustLedgerEntry_gRec.SETRANGE("Closed by Entry No.", CreateCustLedgEntry."Entry No.");
        IF AppliedCustLedgerEntry_gRec.FIND('-') THEN
            REPEAT
                AppliedCustLedgerEntry_gRec.MARK(TRUE);
            UNTIL AppliedCustLedgerEntry_gRec.NEXT = 0;

        AppliedCustLedgerEntry_gRec.SETCURRENTKEY("Entry No.");
        AppliedCustLedgerEntry_gRec.SETRANGE("Closed by Entry No.");

        AppliedCustLedgerEntry_gRec.MARKEDONLY(TRUE);
        IF AppliedCustLedgerEntry_gRec.FINDSET THEN begin
            REPEAT
                if TempBool then
                    EntryList.Add((AppliedCustLedgerEntry_gRec."Entry No."))
                else begin
                    if not EntryList.Contains(AppliedCustLedgerEntry_gRec."Entry No.") then
                        CustomCustCU.CalculateModifiedBalances(AppliedCustLedgerEntry_gRec."Entry No.");
                end;
            UNTIL AppliedCustLedgerEntry_gRec.NEXT = 0;
        end;
    end;
}
