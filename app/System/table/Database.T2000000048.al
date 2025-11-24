table 2000000048 Database
{
    Scope = OnPrem;
    fields
    {
        field(1; "Database Name"; Text[128])
        {
        }
        field(2; Creator; Text[64])
        {
        }
        field(3; Created; Date)
        {
        }
        field(4; "Replication Type"; Option)
        {
            OptionMembers = " ",Published,Subscribed,"Published (Merge)","Subscribed (Merge)";
            OptionCaption = ' ,Published,Subscribed,Published (Merge),Subscribed (Merge)';
        }
        field(5; "My Database"; Boolean)
        {
        }
    }

    keys
    {
        key(pk; "Database Name")
        {
        }
        key(fk1; Creator)
        {
        }
        key(fk2; Created)
        {
        }
    }
}