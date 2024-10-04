table 50301 "Demo Cust Bill"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; CustomerNo; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(2; CustomerName; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(3; CurrentBill; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(4; WaterBill; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; RentBill; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; CalculatedField; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; CustomerNo)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        CalculateSum();
    end;

    trigger OnModify()
    begin
        CalculateSum();
    end;


    procedure CalculateSum()
    begin
        CalculatedField := CurrentBill + RentBill + RentBill;
    end;
}
