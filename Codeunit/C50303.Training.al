codeunit 50303 TraingUnit
{
    trigger OnRun()
    begin
        Filters_lFun();
    end;

    local procedure Filters_lFun()
    var
        Custom_lRec: Record 50301;
        Sales_lRec: Record "Sales Header";
    begin
        Sales_lRec.CopyFilter("Bill-to Name 2", Custom_lRec.CustomerName);
    end;
}
// Copyfilter
// getfilter
// filtergroup
// mark