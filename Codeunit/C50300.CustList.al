codeunit 50300 CustList
{
    trigger OnRun()
    begin
        UniqueCustomerNo();//List usage of Collecting Unique CustomerNo From SalesOrder
    end;

    local procedure UniqueCustomerNo()
    var
        SalesHeader: Record "Sales Header";
        ListOfCustomerNo: List of [Code[20]];
        CustomerNo: Code[20];
    begin
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        if SalesHeader.FindSet() then begin
            repeat
                //Collect unique entries
                if not ListOfCustomerNo.Contains(SalesHeader."Sell-to Customer No.") then
                    ListOfCustomerNo.Add(SalesHeader."Sell-to Customer No.");
            until SalesHeader.Next() = 0;
        end;

        foreach CustomerNo in ListOfCustomerNo do
            message(CustomerNo);

        Message(Format(ListOfCustomerNo.Count));

    end;
}