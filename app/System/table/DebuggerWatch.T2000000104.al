table 2000000104 "Debugger Watch"
{
    Caption = 'Debugger Watch';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;
    ObsoleteState = Removed;
    ObsoleteReason = 'Support for the classic debugger engine has been removed.';

    fields
    {
        field(1; ID; Integer)
        {
            AutoIncrement = true;
            Caption = 'ID';
        }
        field(7; Path; Text[124])
        {
            Caption = 'Path';
        }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
        key(Key2; Path)
        {
        }
    }

    fieldgroups
    {
    }
}

