query 50101 TOp5Customer
{
    QueryType = Normal;
    Caption = 'Top 3 customer By Sales';
    TopNumberOfRows = 10;
    QueryCategory = 'Customer List';
    OrderBy = descending(Sales__LCY_Sum);

    elements
    {
        dataitem(customer_ledger_entry; "Custom CustLed Entry")
        {
            filter(Posting_Date; "Posting Date")
            {


            }
            column(Customer_No_; "Customer No.")
            {

            }
            column(Customer_Name; "Customer Name")
            {

            }
            column(Sales__LCY_Sum; "Sales (LCY)")
            {
                Method = Sum;
            }

        }
    }

    var
        myInt: Integer;

    trigger OnBeforeOpen()
    begin

    end;
}