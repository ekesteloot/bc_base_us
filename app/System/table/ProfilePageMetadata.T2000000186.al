table 2000000186 "Profile Page Metadata"
{
    Caption = 'Profile Page Metadata';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;
    ObsoleteState = Removed;
    ObsoleteReason = 'Support for System Profiles has been removed. Profiles should now be defined in AL extensions and should be accessed through the All Profile virtual table.';
    ObsoleteTag = '22.0';

    fields
    {
        field(1; "Profile ID"; Code[30])
        {
            Caption = 'Profile ID';
            TableRelation = Profile."Profile ID";
        }
        field(2; "Page ID"; Integer)
        {
            Caption = 'Page ID';
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Page));
        }
        field(3; "Page Metadata"; BLOB)
        {
            Caption = 'Page Metadata';
        }
        field(4; "Page AL"; BLOB)
        {
            Caption = 'Page AL';
        }
    }

    keys
    {
        key(Key1; "Profile ID", "Page ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

