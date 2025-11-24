table 2000000165 "Tenant Permission Set"
{
    Caption = 'Tenant Permission Set';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = Cloud;

    fields
    {
        field(1; "App ID"; Guid)
        {
            Caption = 'App ID';
        }
        field(2; "Role ID"; Code[20])
        {
            Caption = 'Role ID';
        }
        field(3; Name; Text[30])
        {
            Caption = 'Name';
        }
        field(4; Assignable; Boolean)
        {
            Caption = 'Assignable';
            InitValue = true;
        }
    }

    keys
    {
        key(Key1; "App ID", "Role ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

