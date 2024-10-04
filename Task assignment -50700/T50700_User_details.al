table 50700 UserDetails
{
    Caption = 'User Details';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; UserID; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Password; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; NoofassignedTasks; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; NoofCompletedAsssignments; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Email; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; UserID)
        {
            Clustered = true;
        }
    }
}