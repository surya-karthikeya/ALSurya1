reportextension 50111 "Standard Sales Quote Ext" extends "Standard Sales - Quote"
{
    dataset
    {
        modify(Header)
        {
            trigger OnAfterAfterGetRecord()
            var
                FormatAddr: Codeunit "Format Address";
                CustAddr: array[8] of Text[100];
            begin
                Clear(CustAddr);
                FormatAddr.SalesHeaderSellTo(CustAddr, Header);
            end;
        }
    }
}