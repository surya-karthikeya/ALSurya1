tableextension 50403 SalesHExt extends "Sales Header"
{
    fields
    {
        field(50001; IsEditable; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; ReferenceNo; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
}


