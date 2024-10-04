// codeunit 50302 Subscriber
// {
//     [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', false, false)]
//     local procedure OnAfterCopyGenJnlLineFromSalesHeader(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
//     begin
//         GenJournalLine.ReferenceNo := SalesHeader.ReferenceNo;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostGLAccOnAfterInitGLEntry', '', false, false)]
//     local procedure OnPostGLAccOnAfterInitGLEntry(var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry");
//     begin
//         GLEntry.ReferenceNo := GenJournalLine.ReferenceNo;
//     end;


//     [EventSubscriber(ObjectType::Page, page::"Sales Order", 'OnBeforeValidateEvent', 'Sell-to Address', false, false)]
//     local procedure OnBeforeValidateEvent(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
//     begin
//         if Rec."Sell-to Address" <> xRec."Sell-to Address" then
//             Error('You cant edit');

//     end;



//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Caption Class", 'OnResolveCaptionClass', '', false, false)]
//     local procedure ResolveCaptionClass(CaptionArea: Text; CaptionExpr: Text; Language: Integer; var Caption: Text; var Resolved: Boolean)
//     begin
//         if CaptionArea = '50100' then begin
//             Caption := CaptionClassTranslate(CaptionExpr);
//             Resolved := true
//         end;
//     end;

//     local procedure CaptionClassTranslate(Caption: Text): Text
//     var
//         MYCaptionType: Text;
//         MyCaptionRef: Text;
//         CommaPosition: Integer;
//     begin
//         CommaPosition := StrPos(Caption, ',');
//         if CommaPosition > 0 then begin
//             MYCaptionType := CopyStr(Caption, 1, CommaPosition - 1);
//             MyCaptionRef := CopyStr(Caption, CommaPosition + 1);
//             case MYCaptionType of
//                 '0':
//                     exit('Caption1');
//                 '1':
//                     exit('Caption2');
//             end;
//         end;
//         exit('');
//     end;
// }

