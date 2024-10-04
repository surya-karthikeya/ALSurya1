query 50100 "List of customers"
{
    QueryType = Normal;
    Caption = 'List of customer';
    QueryCategory = 'Customer List';


    elements
    {
        dataitem(Customer; customer)
        {
            column(No_; "No.")
            {

            }
            filter(Date_Filter; "Date Filter")
            {

            }
        }
    }

    var
        myInt: Integer;

    trigger OnBeforeOpen()
    begin

    end;
}