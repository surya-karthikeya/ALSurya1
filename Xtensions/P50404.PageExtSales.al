pageextension 50404 SalesOrderExt extends "Sales Order"
{
    layout
    {
        addlast("Invoice Details")
        {
            field("Customer Price Group"; Rec."Customer Price Group")
            {
                Visible = true;
                ApplicationArea = all;
            }
        }
        addlast(General)
        {
            field(IsEditable; Rec.IsEditable)
            {
                ApplicationArea = all;
                trigger OnValidate()
                begin
                    if Rec.IsEditable then
                        Editable_gBool := true
                    else
                        Editable_gBool := false;
                end;
            }

            field(ReferenceNo; Rec.ReferenceNo)
            {
                ApplicationArea = All;
            }
        }

        modify("Document Date")
        {
            Editable = Editable_gBool;
        }

    }

    actions
    {
        addlast(processing)
        {
            action(AutoPopulate)
            {
                ApplicationArea = All;
                Caption = 'AutoPopulate', comment = 'NLB="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Insert;
                ToolTip = 'Auto populate the items in sales line';

                trigger OnAction()
                var
                    SalesHeader_lRec: Record "Sales Header";
                    SalesLine_lRec: Record "Sales Line";
                    ItemList_lPage: Page "Item List";
                    Items_lRec: Record Item;
                    I_lInt: Integer;
                begin
                    SalesLine_lRec.SETRANGE("Document Type", SalesHeader_lRec."Document Type");
                    SalesLine_lRec.SETRANGE("Document No.", SalesHeader_lRec."No.");
                    IF SalesLine_lRec.FindLast() THEN
                        ERROR('Record already exists')
                    ELSE BEGIN
                        ItemList_lPage.LOOKUPMODE(TRUE);
                        IF ItemList_lPage.RUNMODAL = ACTION::LookupOK THEN begin
                            ItemList_lPage.SETSELECTIONFILTER(Items_lRec);
                            IF Items_lRec.FINDSET THEN BEGIN
                                I_lInt := 10000;
                                REPEAT
                                    SalesLine_lRec.Init();
                                    SalesLine_lRec.VALIDATE("Line No.", I_lInt);
                                    SalesLine_lRec.VALIDATE("Document Type", SalesHeader_lRec."Document Type");
                                    SalesLine_lRec.VALIDATE("Document No.", SalesHeader_lRec."No.");
                                    SalesLine_lRec.VALIDATE(Type, SalesLine_lRec.Type::Item);
                                    SalesLine_lRec.VALIDATE("No.", Items_lRec."No.");
                                    SalesLine_lRec.VALIDATE(Quantity, 1);
                                    SalesLine_lRec.INSERT;
                                    I_lInt += 10000;
                                UNTIL Items_lRec.NEXT = 0;
                            END;
                        END;
                    END;
                end;
            }
        }

        addafter(AssemblyOrders)
        {
            action(CustomerSalesQuantity)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = New;

                trigger OnAction()
                var
                    MyCodeunit: Codeunit 50311;
                begin
                    Clear(MyCodeunit);
                    MyCodeunit.Run();
                end;
            }
        }
    }
    var
        Editable_gBool: boolean;


    trigger OnAfterGetRecord()
    begin
        if Rec.IsEditable then
            Editable_gBool := true
        else
            Editable_gBool := false;
    end;
}

