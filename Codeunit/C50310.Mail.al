codeunit 50310 SendEmailAuto
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterDeleteAfterPosting', '', false, false)]
    local procedure OnAfterDeleteAfterPosting(SalesHeader: Record "Sales Header"; SalesInvoiceHeader: Record "Sales Invoice Header"; SalesCrMemoHeader: Record "Sales Cr.Memo Header"; CommitIsSuppressed: Boolean)
    var
        //SmtpMailSetup: Record "SMTP Mail Setup";
        //Mail: Codeunit "SMTP Mail";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        CCRecipients: List of [Text];
        BCCRecipients: List of [Text];
        Subject: Text;
        Body: Text;
        SalesPostedTitle: Label 'The Sales Document %2 of Customer %1 has been posted.';
        SalesPostedMsg: Label 'Dear Manager<br><br>The Sales Document <font color="red"><strong>%2</strong></font> of Customer <strong>%1</strong> has been posted.<br> The total amount is <strong>%3</strong>. <br>The Posted Invoice Number is <strong>%4</strong>. <br> User ID <strong>%5</strong>';
    begin
        Recipients.Add('Surya.marrireddy@gmail.com');
        CCRecipients.Add('Bunnymarrireddy@gmail.com');
        SalesInvoiceHeader.CalcFields("Amount Including VAT");
        Subject := StrSubstNo(SalesPostedTitle, SalesHeader."Sell-to Customer Name", SalesHeader."No.");
        Body := StrSubstNo(SalesPostedMsg, SalesHeader."Sell-to Customer Name", SalesHeader."No.", SalesInvoiceHeader."Amount Including VAT", SalesInvoiceHeader."No.", UserId);
        EmailMessage.Create(Recipients, Subject, Body, true, CCRecipients, BCCRecipients);
        EmailMessage.AppendToBody(' <br>  <strong>Thanks for your time</strong>');
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
    end;



    procedure SendEmailWithAttatchment()
    var
        ReportExample: Report "Customer - Top 10 List";
        Email_Cdu: Codeunit Email;
        EmailMessage_Cdu: Codeunit "Email Message";
        Tempblob_Cdu: Codeunit "Temp Blob";
        Instream_Var: InStream;
        OutStream_Var: OutStream;
        ReportParameters: Text;

    begin
        ReportParameters := ReportExample.RunRequestPage();
        Tempblob_Cdu.CreateOutStream(OutStream_Var);
        Report.SaveAs(Report::"Customer - Top 10 List", ReportParameters, ReportFormat::Pdf, OutStream_Var);
        Tempblob_Cdu.CreateInStream(Instream_Var);

        EmailMessage_Cdu.Create('bhatiteena42@gmail.com', 'Customer - Top 10 List Report', 'Please find the attatched document on Report ');
        EmailMessage_Cdu.AddAttachment('Customer - Top 10 List.pdf', 'PDF', Instream_Var);
        Email_Cdu.Send(EmailMessage_Cdu, Enum::"Email Scenario"::Default);
    end;
}