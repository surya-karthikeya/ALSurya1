page 50308 Theater
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Theater;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(EntryNo; rec.EntryNo)
                {
                    ApplicationArea = All;
                }
                field(SelectTheater; rec.SelectTheater)
                {
                    ApplicationArea = All;
                }
                field(Theater; rec.Theater)
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