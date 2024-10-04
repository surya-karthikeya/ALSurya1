page 50312 "Json List Practise"
{
    ApplicationArea = All;
    Caption = 'Json List Practise';
    PageType = List;
    SourceTable = JsonTable;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Id; Rec.Id)
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Username; Rec.Username)
                {
                }
                field(Email; Rec.Email)
                {
                }
                field(Street; Rec.Street)
                {
                }
                field(Suite; Rec.Suite)
                {
                }
                field(City; Rec.City)
                {
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group(JSON)
            {
                action(CreateJson)
                {
                    Caption = 'Download Sample Json';
                    ToolTip = 'Create & download sample Json file';
                    Image = ExportFile;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        ConfirmMsg: Label 'Do you want to download the Json file?';
                        ElseMsg: Label 'No Problem, Try Next Time';
                    begin

                        if Confirm(ConfirmMsg, false) then
                            JsonTesting.CreateJson()
                        else
                            message(elsemsg);
                    end;
                }
                action(APIConnect)
                {
                    Caption = 'API Connect';
                    ToolTip = 'Http Methods response and request';
                    Image = ExportFile;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        ConfirmMsg: Label 'Do you want to test the http methods?';
                        ElseMsg: Label 'No Problem, Try Next Time';
                    begin

                        if Confirm(ConfirmMsg, false) then
                            JsonTesting.APIConnect()
                        else
                            message(elsemsg);
                    end;
                }
            }
        }
    }
    var
        JsonTesting: Codeunit LearnJson;
}
