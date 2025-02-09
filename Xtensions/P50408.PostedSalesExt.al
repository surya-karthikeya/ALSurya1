pageextension 50408 PostedSalesInvExt extends "Posted Sales Invoice"

{

    actions

    {

        addafter(Email)

        {

            action(OpenInOneDrive)

            {

                // The properties provide a look and feel that's consistent with the OneDrive experience in other places of the base application.

                ApplicationArea = Basic, Suite;

                Caption = 'Open in OneDrive';

                ToolTip = 'Copy the file to your Business Central folder in OneDrive and open it in a new window so you can manage or share the file.', Comment = 'OneDrive should not be translated';

                Image = Cloud;

                Promoted = true;

                PromotedCategory = Category6;

                PromotedOnly = true;

                // Enables the action if connection is enabled.

                Enabled = ShareOptionsEnabled;

                trigger OnAction()

                var

                    TempBlob: Codeunit "Temp Blob";

                    DocumentServiceManagement: Codeunit "Document Service Management";

                    InStr: InStream;

                begin

                    GetInvoice(TempBlob);

                    TempBlob.CreateInStream(InStr);

                    // Helper to invoke document sharing flow

                    DocumentServiceManagement.OpenInOneDrive(StrSubstNo(SalesInvoiceName, Rec."No."), '.pdf', InStr);

                end;

            }

            action(ShareInOneDrive)

            {

                // The properties provide a look and feel that's consistent with the OneDrive experience in other places of the base application.

                ApplicationArea = Basic, Suite;

                Caption = 'Share';

                ToolTip = 'Copy the file to your Business Central folder in OneDrive and share it with other people.', Comment = 'OneDrive should not be translated';

                Image = Share;

                Promoted = true;

                PromotedCategory = Category6;

                PromotedOnly = true;

                // Enables the action if connection is enabled.

                Enabled = ShareOptionsEnabled;

                trigger OnAction()

                var

                    TempBlob: Codeunit "Temp Blob";

                    DocumentServiceManagement: Codeunit "Document Service Management";

                    InStr: InStream;

                begin

                    GetInvoice(TempBlob);

                    TempBlob.CreateInStream(InStr);

                    // Helper to invoke document sharing flow

                    DocumentServiceManagement.ShareWithOneDrive(StrSubstNo(SalesInvoiceName, Rec."No."), '.pdf', InStr);

                end;

            }

        }

    }

    var

        ShareOptionsEnabled: Boolean;

        SalesInvoiceName: Label 'Sales Invoice %1';


    trigger OnOpenPage();

    var

        DocumentSharing: Codeunit "Document Sharing";

    begin

        ShareOptionsEnabled := DocumentSharing.ShareEnabled();

    end;

    local procedure GetInvoice(var TempBlob: Codeunit "Temp Blob")

    var

        ReportSelections: Record "Report Selections";

        RecRef: RecordRef;

    begin

        RecRef.GetTable(Rec);

        RecRef.SetRecFilter();

        ReportSelections.GetPdfReportForCust(TempBlob, ReportSelections.Usage::"S.Invoice", RecRef, Rec."Sell-to Customer No.");

    end;

}