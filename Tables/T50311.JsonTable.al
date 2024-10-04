table 50311 JsonTable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Id; Integer)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                JsonTesting: Codeunit LearnJson;
            begin
                JsonTesting.ReadJson(Rec);
            end;
        }
        field(2; Name; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(3; Username; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(4; Email; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(5; Street; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(6; Suite; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(7; City; Text[50])
        {
            DataClassification = ToBeClassified;

        }

    }

    keys
    {
        key(PK; Id)
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