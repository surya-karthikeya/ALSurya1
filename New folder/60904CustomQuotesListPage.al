page 50314 "Custom Quotes List Page"
{
    AdditionalSearchTerms = 'offer';
    ApplicationArea = Basic, Suite;
    Caption = 'Custom Quotes';
    CardPageID = "Custom Quote";
    DataCaptionFields = "Sell-to Customer No.";
    Editable = false;
    PageType = List;
    QueryCategory = 'Custom Quotes';
    RefreshOnActivate = true;
    SourceTable = "Custom Header";
    SourceTableView = where("Document Type" = const(Quote));
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                // field("Document Type"; Rec."Document Type")
                // {
                //     //ApplicationArea= all;
                //     ToolTip = 'Specifies the value of the Document Type field.', Comment = '%';
                // }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field.', Comment = '%';
                }

                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Bill-to Customer No. field.', Comment = '%';
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Bill-to Name field.', Comment = '%';
                }
                // field("Bill-to Name 2"; Rec."Bill-to Name 2")
                // {
                //     //ApplicationArea= all;
                //     ToolTip = 'Specifies the value of the Bill-to Name 2 field.', Comment = '%';
                // }
                // field("Bill-to Address"; Rec."Bill-to Address")
                // {
                //     //ApplicationArea= all;
                //     ToolTip = 'Specifies the value of the Bill-to Address field.', Comment = '%';
                // }
                // field("Bill-to Address 2"; Rec."Bill-to Address 2")
                // {
                //     //ApplicationArea= all;
                //     ToolTip = 'Specifies the value of the Bill-to Address 2 field.', Comment = '%';
                // }
                // field("Bill-to City"; Rec."Bill-to City")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the value of the Bill-to City field.', Comment = '%';
                // }
                // field("Bill-to Contact"; Rec."Bill-to Contact")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the value of the Bill-to Contact field.', Comment = '%';
                // }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Ship-to Contact field.', Comment = '%';
                }

                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    //ApplicationArea= all;
                    ToolTip = 'Specifies the value of the Your Reference field.', Comment = '%';
                }
                // field("Ship-to Code"; Rec."Ship-to Code")
                // {
                //     //ApplicationArea= all;
                //     ToolTip = 'Specifies the value of the Ship-to Code field.', Comment = '%';
                // }
                // field("Ship-to Name"; Rec."Ship-to Name")
                // {
                //     //ApplicationArea= all;
                //     ToolTip = 'Specifies the value of the Ship-to Name field.', Comment = '%';
                // }
                // field("Ship-to Name 2"; Rec."Ship-to Name 2")
                // {
                //     //ApplicationArea= all;
                //     ToolTip = 'Specifies the value of the Ship-to Name 2 field.', Comment = '%';
                // }

                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Ship-to Address field.', Comment = '%';
                }
                // field("Ship-to Address 2"; Rec."Ship-to Address 2")
                // {
                //     //ApplicationArea= all;
                //     ToolTip = 'Specifies the value of the Ship-to Address 2 field.', Comment = '%';
                // }
                // field("Ship-to City"; Rec."Ship-to City")
                // {
                //     //ApplicationArea= all;
                //     ToolTip = 'Specifies the value of the Ship-to City field.', Comment = '%';
                // }

                // field("Order Date"; Rec."Order Date")
                // {
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the value of the Order Date field.', Comment = '%';
                // }
            }
        }
        area(Factboxes)
        {

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
}