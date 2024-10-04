page 50799 "Tenant Media List WS"
{
    Caption = 'Tenant Media List WS';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Tenant Media";
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Contents; Rec.Content)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Mime Type"; Rec."Mime Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}