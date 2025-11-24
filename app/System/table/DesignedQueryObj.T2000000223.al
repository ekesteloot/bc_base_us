table 2000000223 "Designed Query Obj"
{
    DataPerCompany = false;
    Scope = OnPrem;

    fields
    {
        field(1; "Object ID"; Integer)
        {
        }
        field(2; "Object Name"; Text[30])
        {
        }
        field(3; "Unique ID"; Guid)
        {
        }
        field(4; "Query ID"; BigInteger)
        {
        }
    }

    keys
    {
        key(PK; "Object ID")
        {
        }
    }
    fieldGroups
    {
        fieldgroup("DropDown"; "Object ID", "Object Name")
        {
        }
    }
}