// codeunit 50304 Export
// {
//     trigger OnRun()
//     var
//         outputfile_lRec: File;
//         stream: OutStream;
//         NumberOfChars: Text[30];

//     begin

//         // outputfile_lRec.Create('C:\New folder\SalesOrderExport1.xml');
//         // outputfile_lRec.CreateOutStream(Stream);
//         // // Xmlport.Export(1230, Stream);
//         // outputfile_lRec.Close;
//         // Message('Completed');
//         // outputfile_lRec.CREATE('c:\New folder\Hello.txt');  
//         // outputfile_lRec.CREATEOUTSTREAM(stream);  
//         // NumberOfChars := outputfile_lRec.Write('Hello World!');  
//         // MESSAGE('%1 characters were written to the file.', NumberOfChars);
//         ShowTop10CustomersInXml();
//     end;

//     procedure ShowTop10CustomersInXml()
//     var
//         TempBlob: codeunit "Temp Blob";
//         OutStr: OutStream;

//         Content: Text;
//     begin
//         if outputfile_lRe.Create('C:\New folder\SalesOrderExport1.xml') then
//             OutStr := TempBlob.CreateOutStream();
//         Report.SaveAs(Report::"Customer - Top 10 List", '', ReportFormat::Xml, OutStr);
//         Message(Content);
//     end;


//     var
//         outputfile_lRe: File;
// }