tableextension 50406 CustledgerExt extends "Cust. Ledger Entry"
{
    fields
    {
        field(50001; ReferenceNo; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50002; RunningBalance; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Custom CustLed Entry"."Running Balance" WHERE("Entry No." = FIELD("Entry No.")));
        }
        field(50003; InvoiceBalance; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Custom CustLed Entry"."Invoice Balance" WHERE("Entry No." = FIELD("Entry No.")));
        }
    }


}
