table 50303 "Main Vendors"
{
    fields
    {
        field(1; "Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Vendor No." = filter(<> 0)) Vendor."No." where("Balance (LCY)" = filter(>= 10000));
        }


    }
}