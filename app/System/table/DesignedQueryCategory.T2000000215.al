table 2000000215 "Designed Query Category"
{
    Caption = 'Designed Query Category';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        field(1; "Query ID"; BigInteger)
        {
            Caption = 'Query ID';
        }
        field(2; "Order"; Integer)
        {
            Caption = 'Order';
        }
        field(3; "Category"; Text[30])
        {
            Caption = 'Category';
        }
    }

    keys
    {
        key(PK; "Query Id", "Order")
        {
            Clustered = true;
        }
    }
}