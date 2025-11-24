table 2000000007 "Date"
{
    DataPerCompany = False;
    Scope = Cloud;

    //WriteProtected=True;
    fields
    {
        field(1; "Period Type"; Option)
        {
            OptionMembers = "Date",Week,Month,Quarter,Year;
        }
        field(2; "Period Start"; Date)
        {
        }
        field(3; "Period End"; Date)
        {
        }
        field(4; "Period No."; Integer)
        {
        }
        field(5; "Period Name"; Text[31])
        {
        } 
        field(6; "Period Invariant Name"; Text[31])
        {
        }
    }

    keys
    {
        key(pk; "Period Type", "Period Start")
        {

        }
    }
}