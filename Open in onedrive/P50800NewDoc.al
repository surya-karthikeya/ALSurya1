page 50800 "Document Attac. Details New"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Document Attachment";
    Caption = 'Document Attachment Details New';
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("File Extension"; Rec."File Extension")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("File Type"; Rec."File Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(User; Rec.User)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Attached Date"; Rec."Attached Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Tenant Media ID"; TenantMediaGUID)
                {
                    ApplicationArea = All;
                    Editable = false;
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
        TenantMediaGUID: Guid;

    trigger OnAfterGetRecord()
    var
        DocAttchmentExt: Codeunit "Document Attachments Mgt.";
    begin
        TenantMediaGUID := DocAttchmentExt.GetTentantMediaGUID(Rec);
    end;
}