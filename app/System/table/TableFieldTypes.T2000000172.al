table 2000000172 "Table Field Types"
{
    DataPerCompany = false;
    Scope = OnPrem;
    //WriteProtected=true;
    fields
    {
        field(1; "Type ID"; Integer)
        {
        }
        field(2; "Display Name"; Text[30])
        {
        }
        field(3; Description; Text[250])
        {
        }
        field(4; Icon; Media)
        {
        }
        field(5; Blank; Text[64])
        {
        }
        field(6; FieldTypeGroup; Option)
        {
            OptionMembers = Number,Text,Boolean,DateTime,RelatedData,Option;
        }
    }

    keys
    {
        key(pk; "Type ID")
        {
        }
    }

    fieldgroups
    {
        fieldgroup("Brick"; Blank, Icon, "Display Name", Description)
        {
        }
    }
}