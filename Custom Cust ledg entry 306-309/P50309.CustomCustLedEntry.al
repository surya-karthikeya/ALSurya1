page 50309 "Custom Customer Ledger Entries"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Custom Customer Ledger Entries';
    DataCaptionFields = "Customer No.";
    DeleteAllowed = true;
    InsertAllowed = true;
    PageType = List;
    SourceTable = "Custom CustLed Entry";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    ToolTip = 'Specifies the customer entry''s posting date.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    ToolTip = 'Specifies the customer entry''s document date.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the document type that the customer entry belongs to.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the entry''s document number.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    ToolTip = 'Specifies the customer account number that the entry is linked to.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    ToolTip = 'Specifies the customer name that the entry is linked to.';
                    Visible = CustNameVisible;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    Editable = true;
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                    Visible = Dim1Visible;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    ToolTip = 'Specifies the amount of the entry.';
                    // Visible = AmountVisible;
                    Visible = true;
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    ToolTip = 'Specifies the amount of the entry in LCY.';
                    // Visible = AmountVisible;
                    Visible = true;
                }
                field(RunningBalance; Rec."Running Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Running Balance';
                    ToolTip = 'Specifies the running balance';
                    Visible = true;
                }
                field("Invoice Balance"; Rec."Invoice Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Invoice Balance';
                    ToolTip = 'Specifies the invoice balance';
                    Visible = true;
                }

                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the number of the entry, as assigned from the specified number series when the entry was created.';
                }
            }
        }

    }
    actions
    {
        area(Processing)
        {

            action(TransferData)
            {
                Caption = 'Transfer Data';
                Image = Insert;
                Promoted = true;
                PromotedIsBig = true;
                ToolTip = 'Copies data from the customer ledger entries';
                trigger OnAction()
                begin
                    if Confirm('Do you want to copy data from the customer ledger entries', false) then
                        CustomCustCode.TransferDataFun();
                end;
            }
            action(CalRunningBal)
            {
                Caption = 'Calculate Balances';
                Image = Insert;
                Promoted = true;
                PromotedIsBig = true;
                ToolTip = 'Calculated the running balnce of all the customers and invoice balance';
                trigger OnAction()
                begin
                    if Confirm('Do you want to calculate the running balance and invoice balance', false) then
                        CustomCustCode.RunningBalanceFun();
                end;
            }
            action(Customerledger)
            {
                ApplicationArea = All;
                Caption = 'Customer ledger entries';
                RunObject = page "Customer Ledger Entries";
                Promoted = true;
            }
            action(CustomerDetledger)
            {
                ApplicationArea = All;
                Caption = 'Detailed Cust led entries';
                RunObject = page "Detailed Cust. Ledg. Entries";
                Promoted = true;
            }
        }
    }


    var
        CalcRunningCustBalance: Codeunit "Calc. Running Cust. Balance";
        AmountVisible: Boolean;
        DebitCreditVisible: Boolean;
        CustNameVisible: Boolean;
        CustomCustCode: Codeunit CustomCustLedgerEntry;
        NewEntries: Record "Custom CustLed Entry";

    protected var
        Dim1Visible: Boolean;
        Dim2Visible: Boolean;
        Dim3Visible: Boolean;
        Dim4Visible: Boolean;
        Dim5Visible: Boolean;
        Dim6Visible: Boolean;
        Dim7Visible: Boolean;
        Dim8Visible: Boolean;
        StyleTxt: Text;


    local procedure SetDimVisibility()
    var
        DimensionManagement: Codeunit DimensionManagement;
    begin
        DimensionManagement.UseShortcutDims(Dim1Visible, Dim2Visible, Dim3Visible, Dim4Visible, Dim5Visible, Dim6Visible, Dim7Visible, Dim8Visible);
    end;

    local procedure SetControlVisibility()
    var
        GLSetup: Record "General Ledger Setup";
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        GLSetup.Get();
        AmountVisible := not (GLSetup."Show Amounts" = GLSetup."Show Amounts"::"Debit/Credit Only");
        DebitCreditVisible := not (GLSetup."Show Amounts" = GLSetup."Show Amounts"::"Amount Only");
        SalesSetup.Get();
        CustNameVisible := SalesSetup."Copy Customer Name to Entries";
    end;


}