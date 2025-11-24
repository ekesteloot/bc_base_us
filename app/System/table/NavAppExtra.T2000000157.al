table 2000000157 "NAV App Extra"
{
    Caption = 'NAV App Extra';
    DataPerCompany = false;
    Scope = OnPrem;

    fields
    {
		field(1; "Runtime Package ID"; GUID)
        {
            Caption = 'Runtime Package ID';
        }       
        field(2; "Tenant Visible"; Boolean)
        {
            Caption = 'Tenant Visible';
        }
        field(3; "PerTenant Or Installed"; Boolean)
        {
            Caption = 'PerTenant Or Installed';
        }
		field(4; "Package ID"; GUID)
        {
            Caption = 'Package ID';
        }
    }
    keys
    {
        key(Key1; "Runtime Package ID")
        {
        }
    }
}