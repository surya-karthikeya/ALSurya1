page 50311 "Json Testing"
{
    ApplicationArea = All;
    Caption = 'Json Testing';
    PageType = Card;
    SourceTable = JsonTable;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(Id; Rec.Id)
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Username; Rec.Username)
                {
                }
                field(Email; Rec.Email)
                {
                }
                field(Street; Rec.Street)
                {
                }
                field(Suite; Rec.Suite)
                {
                }
                field(City; Rec.City)
                {
                }
            }
        }

    }

}
