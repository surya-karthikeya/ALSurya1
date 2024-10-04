page 50306 XMLExportTest
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    actions
    {
        area(Processing)
        {
            action(ExportXML)
            {
                ApplicationArea = All;
                Promoted = true;
                Image = Export;
                trigger OnAction()
                var
                    XMLTest_lCode: Codeunit XmlDataTest;
                begin
                    XMLTest_lCode.XmlTesting();
                    Message('Finished');
                end;
            }
        }
    }

    var
        myInt: Integer;
}