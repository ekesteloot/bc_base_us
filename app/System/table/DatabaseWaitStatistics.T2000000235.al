table 2000000235 "Database Wait Statistics"
{
    DataPerCompany = false;
    Scope = Cloud;

    fields
    {
        field(1; "Wait Category"; Text[60])
        {
        }
        field(2; "Waiting Tasks Count"; BigInteger)
        {
        }
        field(3; "Wait Time in ms"; BigInteger)
        {
        }
        field(4; "Max Wait Time in ms"; BigInteger)
        {
        }
        field(5; "Signal Wait Time in ms"; BigInteger)
        {
        }
        field(6; "Database start time"; Datetime)
        {
        }

    }
}