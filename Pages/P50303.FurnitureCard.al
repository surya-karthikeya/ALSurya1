page 50303 FurnitureCard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Furniture;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Entryno; Rec.Entryno)
                {
                    ApplicationArea = All;

                }
                field(Furnituretype; Rec.Furnituretype)
                {
                    ApplicationArea = All;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Workstatus; Rec.WorkStatus)
                {
                    ApplicationArea = All;
                }
                field(CheckDate; CheckDate)
                {
                    Caption = 'Check Date';
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        TypeHelper: Codeunit "Type Helper";
                    begin
                        if TypeHelper.IsLeapYear(CheckDate) then
                            IsLeapYear := IsLeapYear::Yes
                        else
                            IsLeapYear := IsLeapYear::No;
                    end;
                }
                field(IsLeapYear; IsLeapYear)
                {
                    Caption = 'Is Leap Year';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    var
        CheckDate: Date;
        IsLeapYear: Option ,Yes,No;
}

