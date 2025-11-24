table 2000000063 "Key"
{
    DataPerCompany = false;
    Scope = Cloud;
    //WriteProtected=True;
    fields
    {
        field(1; TableNo; Integer)
        {
        }
        field(2; "No."; Integer)
        {
        }
        field(3; TableName; Text[30])
        {
        }
        field(4; "Key"; Text[250])
        {
        }
        field(5; SumIndexFields; Text[250])
        {
        }
        field(6; SQLIndex; Text[250])
        {
        }
        field(7; Enabled; Boolean)
        {
        }
        field(8; MaintainSQLIndex; Boolean)
        {
        }
        field(9; MaintainSIFTIndex; Boolean)
        {
        }
        field(10; Clustered; Boolean)
        {
        }
        field(11; ObsoleteState; Option)
        {
            Caption = 'ObsoleteState';
            OptionMembers = No,Pending,Removed;
        }
        field(12; ObsoleteReason; Text[30])
        {
            Caption = 'ObsoleteReason';
        }
        field(13; Unique; Boolean)
        {
        }
    }

    keys
    {
        key(pk; TableNo, "No.")
        {

        }
    }
}
