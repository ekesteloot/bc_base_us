table 2000000178 "All Profile"
{
    Caption = 'All Profile';
    DataPerCompany = false;
    Scope = Cloud;

    fields
    {
        field(1; Scope; Option)
        {
            OptionMembers = System,Tenant;
            OptionCaption = 'System,Tenant';
        }
        field(2; "App ID"; Guid)
        {
        }
        field(3; "Profile ID"; Code[30])
        {
        }
        field(4; Description; Text[2048])
        {
        }
        field(5; "Role Center ID"; Integer)
        {
        }
        field(6; "Default Role Center"; Boolean)
        {
        }
        field(7; "Use Comments"; Boolean)
        {
        }
        field(8; "Use Notes"; Boolean)
        {
        }
        field(9; "Use Record Notes"; Boolean)
        {
        }
        field(10; "Record Notebook"; Text[250])
        {
        }
        field(11; "Use Page Notes"; Boolean)
        {
        }
        field(12; "Page Notebook"; Text[250])
        {
        }
        field(13; "Disable Personalization"; Boolean)
        {
        }
        field(14; "App Name"; Text[250])
        {
        }
        field(15; "Enabled"; Boolean)
        {
        }
        field(16; Caption; Text[100])
        {
        }
        field(17; Promoted; Boolean)
        {
        }
    }
    keys
    {
        key(PK; Scope, "App ID", "Profile ID")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Profile ID", "App Name")
        {
        }
        fieldgroup(Brick; "App Name", Caption, "Profile ID")
        {
        }
    }
}