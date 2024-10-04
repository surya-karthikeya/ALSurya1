page 50313 CustomTest
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = CustomTest;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(TestName; Rec.TestName)
                {
                    ApplicationArea = All;

                }
                field("Test No"; Rec."Test No")
                {
                    ApplicationArea = All;

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

    trigger OnOpenPage()
    begin
        Message('Hello');
    end;
}