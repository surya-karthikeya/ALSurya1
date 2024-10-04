codeunit 50800 "Document Attachments Mgt."
{
    trigger OnRun()
    begin

    end;

    procedure GetTentantMediaGUID(var DocumentAttachment: Record "Document Attachment"): Guid;
    var
        TenantMedia: Record "Tenant Media";
    begin
        TenantMedia.Get(DocumentAttachment."Document Reference ID".MediaId);
        exit(TenantMedia.ID);
    end;
}