codeunit 50301 CustDict
{
    trigger OnRun()
    begin
        CustomerNoAndCustName(); //Dictinary usage Collect unique entries with name
    end;

    local procedure CustomerNoAndCustName()
    var
        SalesHeader: Record "Sales Header";
        CustomerDict: Dictionary of [Code[20], Text];
        CustomerNo: Code[20];
        CustomerName: Text;
    begin
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        if SalesHeader.FindSet() then begin
            repeat
                if not CustomerDict.ContainsKey(SalesHeader."Sell-to Customer No.") then
                    CustomerDict.Set(SalesHeader."Sell-to Customer No.", SalesHeader."Sell-to Customer Name");
            until SalesHeader.Next() = 0;
        end;
        foreach CustomerNo in CustomerDict.Keys() do begin
            CustomerName := CustomerDict.Get(CustomerNo);
            Message('%1, %2', CustomerNo, CustomerName);
        end;
    end;

}
