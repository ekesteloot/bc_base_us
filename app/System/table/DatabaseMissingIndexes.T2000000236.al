table 2000000236 "Database Missing Indexes"
{
    DataPerCompany = false;
    Scope = Cloud;

    //WriteProtected=True;
    fields
    {
        field(1; "Index Handle"; Integer)
        {
        }
        field(2; "Table Name"; Text[128])
        {
        }
        field(3; "Extension Id"; Guid)
        {
        }
        field(4; "Index Equality Columns"; Text[2048])
        {
        }
        field(5; "Index Inequality Columns"; Text[2048])
        {
        }
        field(6; "Index Include Columns"; Text[2048])
        {
        }
        field(7; "Statement"; Text[2048])
        {
        }
    }
}