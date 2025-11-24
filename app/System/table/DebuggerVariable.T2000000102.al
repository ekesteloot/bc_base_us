table 2000000102 "Debugger Variable"
{
    Scope = OnPrem;
    ObsoleteState = Removed;
    ObsoleteReason = 'Support for the classic debugger engine has been removed.';

    fields
    {
        field(1; "Call Stack ID"; Integer)
        {
            TableRelation = "Debugger Call Stack".ID;
        }
        field(3; "Variable ID"; Integer)
        {
        }
        field(5; Indentation; Integer)
        {
        }
        field(7; Path; Text[124])
        {
        }
        field(9; Name; Text[124])
        {
        }
        field(11; Value; Text[250])
        {
        }
        field(13; Type; Text[128])
        {
        }
    }

    keys
    {
        key(pk; "Call Stack ID", "Variable ID")
        {

        }
    }
}