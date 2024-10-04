table 50316 "Custom Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Document Type';
        }
        field(2; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            TableRelation = Customer;
            ValidateTableRelation = true;
            trigger OnValidate()
            var
                Cust_gRec: Record Customer;
            begin
                Cust_gRec.Reset();
                if Cust_gRec.get(Rec."Sell-to Customer No.") then begin
                    Rec.Validate("Bill-to Customer No.", Cust_gRec."Bill-to Customer No.");
                    Rec.validate("Bill-to Name", Cust_gRec.Name);
                    Rec.Validate("Bill-to Name 2", Cust_gRec."Name 2");
                    Rec.Validate("Bill-to Address", Cust_gRec.Address);
                    Rec.Validate("Bill-to Address 2", Cust_gRec."Address 2");
                    Rec.Validate("Bill-to City", Cust_gRec.City);
                    Rec.Validate("Bill-to Contact", Cust_gRec.Contact);
                    Rec.Validate("Ship-to Code", Cust_gRec."Ship-to Code");
                    Rec.Validate("Ship-to Name", Cust_gRec.Name);
                    Rec.Validate("Ship-to Name 2", Cust_gRec."Name 2");
                    Rec.Validate("Ship-to Address", Cust_gRec.Address);
                    Rec.Validate("Ship-to Address 2", Cust_gRec."Address 2");
                    Rec.Validate("Ship-to City", Cust_gRec.City);
                    Rec.Validate("Ship-to Contact", Cust_gRec.Contact);
                    Rec.Validate("Order Date", Today);
                    Rec.Validate("Posting Date", Today);
                end;
            end;

        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
            trigger OnValidate()
            var
            // newcustnoseries: Record "New Cust No Series";

            begin
                // if "No." < xRec."No." then
                //     if not newcustnoseries.Get(Rec."No.") then begin
                //         SalesSetup.Get();
                //         NoSeries.TestManual(SalesSetup."Book Nos.");
                //         "No. Series" := '';
                //     end;
            end;

        }

        field(4; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';

        }
        field(5; "Bill-to Name"; Text[100])
        {
            Caption = 'Bill-to Name';

        }
        field(6; "Bill-to Name 2"; Text[50])
        {
            Caption = 'Bill-to Name 2';
        }
        field(7; "Bill-to Address"; Text[100])
        {
            Caption = 'Bill-to Address';

        }
        field(8; "Bill-to Address 2"; Text[50])
        {
            Caption = 'Bill-to Address 2';

        }
        field(9; "Bill-to City"; Text[30])
        {
            Caption = 'Bill-to City';
        }
        field(10; "Bill-to Contact"; Text[100])
        {
            Caption = 'Bill-to Contact';


        }
        field(11; "Your Reference"; Text[35])
        {
            Caption = 'Your Reference';
        }
        field(12; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';

        }
        field(13; "Ship-to Name"; Text[100])
        {
            Caption = 'Ship-to Name';
        }
        field(14; "Ship-to Name 2"; Text[50])
        {
            Caption = 'Ship-to Name 2';
        }
        field(15; "Ship-to Address"; Text[100])
        {
            Caption = 'Ship-to Address';
        }
        field(16; "Ship-to Address 2"; Text[50])
        {
            Caption = 'Ship-to Address 2';
        }
        field(17; "Ship-to City"; Text[30])
        {
            Caption = 'Ship-to City';

        }
        field(18; "Ship-to Contact"; Text[100])
        {
            Caption = 'Ship-to Contact';
        }
        field(19; "Order Date"; Date)
        {

            Caption = 'Order Date';


        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';


        }
        field(21; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";

        }
    }

    keys
    {
        key(Pk; "Document Type", "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";

    // trigger OnInsert()
    // begin
    //     if "No." = '' then begin
    //         SalesSetup.Get();
    //         SalesSetup.TestField("Book Nos.");
    //         "No. Series" := SalesSetup."Book Nos.";
    //         if NoSeries.AreRelated(SalesSetup."Book Nos.", xRec."No. Series") then
    //             "No. Series" := xRec."No. Series";
    //         "No." := NoSeries.GetNextNo("No. Series");
    //     end;
    // end;

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