codeunit 50305 XmlDataTest
{
    procedure XmlTesting()
    var
        XMLDoc_lVar: XmlDocument;
        XMLDec_lVar: XmlDeclaration;
        RootNode_lVar: XmlElement;
        ParentNode_lVar: XmlElement;
        Custmer_lRec: Record Customer;
        FiledCaption_lTex: Text;
        XMLTxt_lVar: XmlText;
        ChildNode_lVar: XmlElement;
        TempBlob_lVar: Codeunit "Temp Blob";
        InStr_lVar: InStream;
        OutStr_lVar: OutStream;
        ReadTxt_lTxt: Text;
        WriteTxt_lTxt: Text;
    begin
        XMLDoc_lVar := XmlDocument.Create();
        XMLDec_lVar := XmlDeclaration.Create('1.0', 'UTF-8', '');
        XMLDoc_lVar.SetDeclaration(XMLDec_lVar);
        RootNode_lVar := XmlElement.Create('Table');
        XMLDoc_lVar.Add(RootNode_lVar);
        Custmer_lRec.FindSet();
        repeat
            //Customer No.
            ParentNode_lVar := XmlElement.Create('Customer');
            RootNode_lVar.Add(ParentNode_lVar);
            FiledCaption_lTex := Custmer_lRec.FieldCaption("No.");
            ChildNode_lVar := XmlElement.Create(FiledCaption_lTex);
            XMLTxt_lVar := XmlText.Create(Custmer_lRec."No.");
            ChildNode_lVar.Add(XMLTxt_lVar);
            ParentNode_lVar.Add(ChildNode_lVar);

            //Customer Name
            RootNode_lVar.Add(ParentNode_lVar);
            FiledCaption_lTex := Custmer_lRec.FieldCaption(Name);
            ChildNode_lVar := XmlElement.Create(FiledCaption_lTex);
            XMLTxt_lVar := XmlText.Create(Custmer_lRec.Name);
            ChildNode_lVar.Add(XMLTxt_lVar);
            ParentNode_lVar.Add(ChildNode_lVar);

            //Customer Balance
            Custmer_lRec.CalcFields(Balance);
            RootNode_lVar.Add(ParentNode_lVar);
            FiledCaption_lTex := Custmer_lRec.FieldCaption(Balance);
            ChildNode_lVar := XmlElement.Create(FiledCaption_lTex);
            XMLTxt_lVar := XmlText.Create(Format(Custmer_lRec.Balance));
            ChildNode_lVar.Add(XMLTxt_lVar);
            ParentNode_lVar.Add(ChildNode_lVar);
        until Custmer_lRec.Next() = 0;


        TempBlob_lVar.CreateInStream(InStr_lVar);
        TempBlob_lVar.CreateOutStream(OutStr_lVar);
        XMLDoc_lVar.WriteTo(OutStr_lVar);
        OutStr_lVar.WriteText(WriteTxt_lTxt);
        InStr_lVar.ReadText(WriteTxt_lTxt);
        ReadTxt_lTxt := 'Customer.XML';
        DownloadFromStream(InStr_lVar, '', '', '', ReadTxt_lTxt);


    end;


    var
        myInt: Integer;
}