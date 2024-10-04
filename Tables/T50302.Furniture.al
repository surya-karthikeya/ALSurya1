table 50302 Furniture
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Entryno; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(2; Furnituretype; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Table","Chair","Sofa";
        }
        field(3; Description; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; WorkStatus; Enum WorkStaus)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; Entryno)
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
        Message('Inserted');
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