table 50702 AssignedTasks
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; EntryNo; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; AssignedDate; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; Assignedby; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; AssignedTo; Code[50])
        {
            Editable = false;
        }
        field(5; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Assigned,Completed;
            Editable = false;
        }
        field(6; DeadLine; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; DescriptionTask; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; Completed; Boolean)
        {
            trigger OnValidate()
            begin
                if Completed then
                    Status := Status::Completed
                else
                    Status := Status::Assigned

            end;
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