page 50300 "Demo Cust Bill List Page"
{
    ApplicationArea = All;
    Caption = 'Demo CustomBill';
    PageType = List;
    SourceTable = "Demo Cust Bill";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(CustomerNo; Rec.CustomerNo)
                {
                    ToolTip = 'Specifies the value of the CustomerNo field.';
                }
                field(CustomerName; Rec.CustomerName)
                {
                    ToolTip = 'Specifies the value of the CustomerName field.';
                }
                field(RentBill; Rec.RentBill)
                {
                    ToolTip = 'Specifies the value of the RentBill field.';
                }
                field(CurrentBill; Rec.CurrentBill)
                {
                    ToolTip = 'Specifies the value of the CurrentBill field.';
                }
                field(CalculatedField; Rec.CalculatedField)
                {
                    ToolTip = 'Specifies the value of the CalculatedField field.';
                }
                field(WaterBill; Rec.WaterBill)
                {
                    ToolTip = 'Specifies the value of the WaterBill field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
            }
        }
    }
}
