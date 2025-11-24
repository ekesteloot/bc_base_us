table 2000000155 "NAV App Publish Reference"
{
    Caption = 'NAV App Publish Reference';
    DataPerCompany = false;
    Scope = OnPrem;
    ReplicateData = false;
    ObsoleteState = Removed;
    ObsoleteReason = 'This table has been deprecated with the support for per tenant extensions.';
    fields
    {
        field(1; "Tenant ID"; Text[128])
        {
            Caption = 'Tenant ID';
        }
        field(2; "App Package ID"; Guid)
        {
            Caption = 'App Package ID';
        }
    }

    keys
    {
        key(Key1; "Tenant ID", "App Package ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

