table 50312 CustomTest
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; TestName; Text[30])
        {
            Caption = 'Test Name';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin

            end;

        }
        field(2; "Test No"; Code[20])
        {
            Caption = 'Test No';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; TestName)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}