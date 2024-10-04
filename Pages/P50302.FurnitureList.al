page 50302 FurnitureList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Furniture;
    CardPageId = FurnitureCard;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Entryno; Rec.Entryno)
                {
                    ApplicationArea = All;


                }
                field(Furnituretype; Rec.Furnituretype)
                {
                    ApplicationArea = All;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                    CaptionClass = '50100,0,0';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group(CodeUnits)
            {
                ToolTip = 'To check the codeunits';
                action(Notify)
                {
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        Message('Notified');
                    end;
                }

                action(CheckKList)
                {
                    ApplicationArea = All;
                    RunObject = codeunit CustList;
                }

                action(CheckDict)
                {
                    ApplicationArea = All;
                    RunObject = codeunit CustDict;
                }
                // action(Training)
                // {
                //     ApplicationArea = All;
                //     RunObject = codeunit Export;
                // }
                action(CheckDate)
                {
                    ApplicationArea = All;
                    RunObject = codeunit BussinessdateCal;
                }
                action(SendMail)
                {
                    ApplicationArea = All;
                    Caption = 'Send Mail';

                    trigger OnAction()
                    var
                        Mail_Cdu: Codeunit SendEmailAuto;
                    begin
                        Mail_Cdu.SendEmailWithAttatchment();
                    end;
                }
            }



        }
    }

    var
        myInt: Integer;
}