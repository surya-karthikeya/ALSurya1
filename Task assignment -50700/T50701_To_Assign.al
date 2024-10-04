table 50701 ToAssignTask
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; EntryNo; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            trigger OnValidate()
            begin
                AssignedDate := Today;
                Assignedby := UserId;
            end;
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
        field(4; AssisingTo; Code[50])
        {
            TableRelation = UserDetails;
        }
        field(5; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = Assigned,Completed;
        }
        field(6; DeadLine; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(7; DescriptionTask; Text[200])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                User_lRec: Record UserDetails;
            begin
                if User_lRec.Get(AssisingTo) then
                    EmailId := User_lRec.Email;
            end;
        }
        field(8; EmailId; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
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
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];

    trigger OnInsert()
    var
        Assigned_lRec: Record AssignedTasks;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        Subject: Text[50];
        Body: Text[200];
    begin
        Assigned_lRec.Reset();
        Assigned_lRec.Init();
        Assigned_lRec.AssignedDate := AssignedDate;
        Assigned_lRec.Assignedby := Assignedby;
        Assigned_lRec.AssignedTo := AssisingTo;
        Assigned_lRec.DescriptionTask := DescriptionTask;
        Assigned_lRec.DeadLine := DeadLine;
        Assigned_lRec.Insert();

        Recipients.Add(Rec.EmailId);
        Subject := 'New Task';
        Body := 'Do check the new task which is assigned to in the ALLOCATED TASKS page';
        EmailMessage.Create(Recipients, Subject, Body, true);
        EmailMessage.AppendToBody(' <br>  <strong>Complete it ASAP</strong>');
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
    end;

    trigger OnModify()
    begin

    end;

}