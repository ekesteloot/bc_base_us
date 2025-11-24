table 2000000135 "Table Synch. Setup"
{
    DataPerCompany = False;
    Scope = OnPrem;

    fields
    {
        field(1; "Table ID"; Integer)
        {
        }
        field(2; "Upgrade Table ID"; Integer)
        {
        }
        field(3; "Mode"; Option)
        {
            OptionMembers = Check,Copy,Move,Force;
        }
    }

    keys
    {
        key(pk; "Table ID")
        {
        }
    }
}