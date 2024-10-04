page 50700 UserDetails
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = UserDetails;
    Caption = 'User Details';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(UserID; Rec.UserID)
                {
                    ApplicationArea = All;
                    Caption = 'User ID';
                }
                field(Password; Rec.Password)
                {
                    ApplicationArea = All;
                    Caption = 'Password';
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                    Caption = 'Email Id';
                }
                field(NoofassignedTasks; Rec.NoofassignedTasks)
                {
                    ApplicationArea = All;
                    Caption = 'No of assigned tasks';
                    Editable = false;
                }
                field(NoofCompletedAsssignments; Rec.NoofCompletedAsssignments)
                {
                    ApplicationArea = All;
                    Caption = 'No of completed tasks';
                    Editable = false;
                }


            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}