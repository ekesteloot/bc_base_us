table 2000000004 "Permission Set"
{
    Caption = 'Permission Set';
    DataCaptionFields = "Role ID", Name;
    DataPerCompany = false;
    ReplicateData = false;
    Scope = Cloud;
    ObsoleteState = Pending;
    ObsoleteReason = 'Internal table which will be moved to the OnPrem scope in next major release.';

    fields
    {
        field(1; "Role ID"; Code[20])
        {
            Caption = 'Role ID';
        }
        field(2; Name; Text[30])
        {
            Caption = 'Name';
        }
        field(3; Hash; Text[250])
        {
            Caption = 'Hash';
        }
    }

    keys
    {
        key(Key1; "Role ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

