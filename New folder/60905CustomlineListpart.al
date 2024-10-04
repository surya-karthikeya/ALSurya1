page 50315 "Custom Line listpart"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Custom Line";
    SourceTableView = where("Document Type" = filter(Quote));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                    trigger OnValidate()
                    begin
                        UpdateTypeText();
                    end;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                    trigger OnValidate()
                    begin
                        UpdateTypeText();
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    //ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field.', Comment = '%';
                }
                field("Document No."; Rec."Document No.")
                {
                    //ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.', Comment = '%';
                }
                field("Line No."; Rec."Line No.")
                {
                    //ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                }


                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field.', Comment = '%';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = '%';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Price field.', Comment = '%';
                }
                field("Qty. to Invoice"; Rec."Qty. to Invoice")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty. to Invoice field.', Comment = '%';
                }
                field("Qty. to Ship"; Rec."Qty. to Ship")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty. to Ship field.', Comment = '%';
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    //ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Group field.', Comment = '%';
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipment Date field.', Comment = '%';
                }

                field("Description 2"; Rec."Description 2")
                {
                    //ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description 2 field.', Comment = '%';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit of Measure field.', Comment = '%';
                }

                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    //ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Outstanding Quantity field.', Comment = '%';
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
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if xRec."Document No." = '' then
            Rec.Type := Rec.Type::Item;
        UpdateTypeText();
        Evaluate(Rec.Type, TypeAsText);
        Rec.Validate(Type);

    end;

    trigger OnAfterGetCurrRecord()
    begin
        UpdateTypeText();
    end;

    local procedure UpdateTypeText()
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Rec);
        TypeAsText := TempOptionLookupBuffer.FormatOption(RecRef.Field(Rec.FieldNo(Type)));
    end;

    var

        TypeAsText: Text[30];
        TempOptionLookupBuffer: Record "Option Lookup Buffer" temporary;
}