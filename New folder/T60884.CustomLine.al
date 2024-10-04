table 50314 "Custom Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Document Type';

        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Sales Header"."No." where("Document Type" = field("Document Type"));

        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; Type; Enum "Sales Line Type")
        {
            Caption = 'Type';

        }
        field(6; "No."; Code[20])
        {

            Caption = 'No.';
            TableRelation = if (Type = const(" ")) "Standard Text"
            else
            if (Type = const("G/L Account"), "System-Created Entry" = const(false)) "G/L Account" where("Direct Posting" = const(true), "Account Type" = const(Posting), Blocked = const(false))
            else
            if (Type = const("G/L Account"), "System-Created Entry" = const(true)) "G/L Account"
            else
            if (Type = const(Resource)) Resource
            else
            if (Type = const("Fixed Asset")) "Fixed Asset"
            else
            if (Type = const("Charge (Item)")) "Item Charge"
            else
            if (Type = const("Allocation Account")) "Allocation Account"
            else
            if (Type = const(Item), "Document Type" = filter(<> "Credit Memo" & <> "Return Order")) Item where(Blocked = const(false), "Sales Blocked" = const(false))
            else
            if (Type = const(Item), "Document Type" = filter("Credit Memo" | "Return Order")) Item where(Blocked = const(false));
            ValidateTableRelation = false;
            trigger OnValidate()
            var
                GLAccount_lRec: Record "G/L Account";
                Item_lRec: Record Item;
                resource_lRec: Record Resource;
                AllocationAccount_lRec: Record "Allocation Account";
                FixedAssert_lRec: Record "Fixed Asset";
            begin
                if type = type::"G/L Account" then begin
                    if GLAccount_lRec.get(Rec."No.") then
                        Rec.Validate(Description, GLAccount_lRec.Name);
                    //Rec.Description := GLAccount_lRec.Name;
                end
                else
                    if type = type::Item then begin
                        if Item_lRec.get(Rec."No.") then
                            Rec.Validate(Description, Item_lRec.Description);
                        //Rec.Description := Item_lRec.Description;
                    end
                    else
                        if Type = type::"Allocation Account" then begin
                            if AllocationAccount_lRec.Get(Rec."No.") then
                                Rec.validate(Description, AllocationAccount_lRec.Name);
                            //Rec.Description := AllocationAccount_lRec.name;
                        end
                        else
                            if type = type::Resource then begin
                                if resource_lRec.Get(Rec."No.") then
                                    Rec.Validate(Description, resource_lRec.Name);
                                //Rec.Description := resource_lRec.Name;
                            end
                            else
                                if Type = type::"Fixed Asset" then begin
                                    if FixedAssert_lRec.get(Rec."No.") then
                                        Rec.Validate(Description, FixedAssert_lRec.Description);
                                end

                                else
                                    if type = type::" " then
                                        Rec.Validate(Description, '');

            end;


        }
        field(2; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            Editable = false;
            TableRelation = Customer;
        }

        field(7; "Location Code"; Code[10])
        {
            Caption = 'Location Code';

        }
        field(8; "Posting Group"; Code[20])
        {
            Caption = 'Posting Group';

        }
        field(10; "Shipment Date"; Date)
        {

            Caption = 'Shipment Date';


        }
        field(11; Description; Text[100])
        {
            Caption = 'Description';

        }
        field(12; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(13; "Unit of Measure"; Text[50])
        {
            Caption = 'Unit of Measure';

        }
        field(15; Quantity; Decimal)
        {
            Caption = 'Quantity';

        }
        field(16; "Outstanding Quantity"; Decimal)
        {
            Caption = 'Outstanding Quantity';

        }
        field(17; "Qty. to Invoice"; Decimal)
        {
            Caption = 'Qty. to Invoice';

        }
        field(18; "Qty. to Ship"; Decimal)
        {

            Caption = 'Qty. to Ship';

        }
        field(22; "Unit Price"; Decimal)
        {

            Caption = 'Unit Price';

        }
        field(101; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
            Editable = false;
        }
    }

    keys
    {
        key(Pk; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}