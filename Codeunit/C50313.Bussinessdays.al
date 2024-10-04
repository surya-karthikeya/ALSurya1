codeunit 50313 BussinessdateCal
{
    trigger OnRun()
    begin
        PrintName('Surya', 50.50);
        Message(Format(CalculateBusinessDays(20240702D, 20240716D)));
    end;

    procedure PrintName(Name: Text[50]; Amount: Decimal)
    begin
        Message('Dear %1, %2', Name, Amount);
    end;

    procedure CalculateBusinessDays(StartDate: Date; EndDate: Date): Integer
    var
        BusinessDays: Integer;
        CurrentDate: Date;
    begin
        BusinessDays := 0;
        CurrentDate := StartDate;
        while CurrentDate <= EndDate do begin
            case Date2DWY(CurrentDate, 1) of
                1 .. 5:
                    BusinessDays += 1;
            end;
            CurrentDate := CurrentDate + 1;
        end;
        exit(BusinessDays);
    end;
}