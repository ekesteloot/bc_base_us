table 2000000164 "Time Zone"
{
    DataPerCompany = False;
    Scope = Cloud;
    //WriteProtected=True;
    fields
    {
        field(1; ID; Text[180])
        { //TODO
        }
        field(2; "Display Name"; Text[250])
        {
        }
        field(3; "No."; Integer)
        {
        }
    }

    keys
    {
        key(pk; "No.")
        {

        }
        key(fk; "Display Name")
        {

        }
    }
}