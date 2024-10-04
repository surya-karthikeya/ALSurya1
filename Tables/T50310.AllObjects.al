table 50310 AllObjectscustom
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(3; "Object Type"; option)
        {
            OptionMembers = "TableData","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber",,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension","PermissionSet","PermissionSetExtension","ReportExtension";
            OptionCaption = 'TableData,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,System,FieldNumber,,,PageExtension,TableExtension,Enum,EnumExtension,Profile,ProfileExtension,PermissionSet,PermissionSetExtension,ReportExtension';
        }
        field(4; "Object ID"; Integer)
        {
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = field("Object Type"));
            trigger OnValidate()
            var
                Hiddentable: Record AllObjWithCaption;
            begin
                Hiddentable.Reset();
                if Hiddentable.get("Object Type", "Object ID") then
                    "Custom Object Name" := 'Hello ' + Hiddentable."Object Name";
                Message("Custom Object Name");

            end;
        }
        field(5; "Object Name"; Text[30])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(AllObjWithCaption."Object Name" WHERE("Object ID" = FIELD("Object ID")));
            Editable = false;
        }
        field(6; "Custom Object Name"; Text[50])
        {
        }
    }

    keys
    {
        key(Pk; "Entry No")
        {
            Clustered = true;
        }
    }
}