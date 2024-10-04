table 50305 TicketsTable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; EntryNo; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11; CustomerName; Text[100])
        {

            TableRelation = Customer.Name;

        }
        field(12; SelectTheater; Option)
        {
            OptionMembers = "Single Screen",Multiplex;

        }
        field(13; Theater; Text[50])
        {

            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(PK; EntryNo)
        {
            Clustered = true;
        }
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