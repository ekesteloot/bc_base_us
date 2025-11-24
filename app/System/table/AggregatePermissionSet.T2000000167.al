table 2000000167 "Aggregate Permission Set"
{
    DataPerCompany = false;
    Scope = Cloud;

    //WriteProtected=True;
    fields
    {
        field(1; Scope; Option)
        {
            OptionMembers = System,Tenant;
        }
        field(2; "App ID"; Guid)
        {
        }
        field(3; "Role ID"; Code[20])
        {
        }
        field(4; Name; Text[30])
        {
        }
        field(5; "App Name"; Text[250])
        {
        }
    }
    keys
    {
        key(pk; Scope, "App ID", "Role ID")
        {
        }
    }

    fieldgroups
    {
        fieldgroup("DropDown"; "Role ID", Name, "App Name")
        {

        }
    }
}