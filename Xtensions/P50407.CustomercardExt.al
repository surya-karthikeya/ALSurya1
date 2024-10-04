pageextension 50120 CustomerCardExt extends "Customer Card"
{
    layout
    {
        modify("Address 2")
        {
            trigger OnAfterValidate()
            var
                TypeHelper: Codeunit "Type Helper";
                CharNo: Integer;
                i: Integer;
            begin
                for i := 1 to StrLen(Rec."Address 2") do begin
                    CharNo := Rec."Address 2"[i];
                    if TypeHelper.IsDigit(CharNo) then
                        Message('%1 is a digit', Rec."Address 2"[i])
                    else
                        Message('%1 is not a digit', Rec."Address 2"[i]);
                end;
            end;
        }

        addafter(Name)
        {
            field(ItemFilter; ItemFilter)
            {
                Caption = 'Item Filter';
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                var
                    ItemList: Page "Item List";
                begin
                    Clear(ItemFilter);
                    ItemList.LookupMode(true);
                    if ItemList.RunModal() = Action::LookupOK then begin
                        Text += ItemList.GetSelectionFilter();
                        exit(true);
                    end else
                        exit(false);
                end;
            }
        }
    }
    var
        ItemFilter: Code[250];
}