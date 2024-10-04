pageextension 50407 UnapplyCustomer extends "Unapply Customer Entries"
{
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        SLSingleInstanceCodU: Codeunit "SL Single Instance Codeunit";
    begin
        if CloseAction IN [ACTION::Cancel, ACTION::LookupOK, Action::LookupCancel] THEN
            SLSingleInstanceCodU.ClearFilters_Fun();
    end;
}