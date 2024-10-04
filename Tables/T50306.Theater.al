table 50306 Theater
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; EntryNo; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(2; SelectTheater; Option)
        {
            OptionMembers = "Single Screen",Multiplex;

        }
        field(3; Theater; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(pk; EntryNo)
        {
            Clustered = true;
        }
    }

}