pageextension 50406 CustLedgerExt extends "Customer Ledger Entries"
{
    layout
    {
        addbefore("Entry No.")
        {

            field(ReferenceNo; Rec.ReferenceNo)
            {
                ApplicationArea = all;
            }

            field(RunningBalance; Rec.RunningBalance)
            {
                ApplicationArea = all;
            }
            field(InvoiceBalance; Rec.InvoiceBalance)
            {
                ApplicationArea = all;
            }



        }
    }
}