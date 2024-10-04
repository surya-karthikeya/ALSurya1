page 50310 AllObjectscustom
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = AllObjectscustom;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Object Type"; Rec."Object Type")
                {
                    ApplicationArea = All;

                }
                field("Object ID"; Rec."Object ID")
                {
                    ApplicationArea = All;

                }
                field("Object Name"; Rec."Object Name")
                {
                    ApplicationArea = All;
                }
                field("Custom Object Name"; Rec."Custom Object Name")
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
}