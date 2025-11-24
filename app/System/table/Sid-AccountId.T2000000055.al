table 2000000055 "SID - Account ID"
{
    DataPerCompany = false;
    Scope = OnPrem;
    //WriteProtecte=True;
    fields
    {
        field(1; SID; text[118])
        {
        }
        field(2; ID; text[130])
        {
        }
    }

    keys
    {
        key(pk; SID)
        {

        }
        key(fk; ID)
        {

        }
    }
}