table 2000000020 Drive
{
    Scope = OnPrem;

    fields
    {
        field(1; Drive; Code[2])
        {
        }
        field(2; Removable; Boolean)
        {
        }
        field(3; "Size (KB)"; Integer)
        {
        }
        field(4; "Free (KB)"; Integer)
        {
        }
    }

    keys
    {
        key(pk; Drive)
        {

        }
    }
}