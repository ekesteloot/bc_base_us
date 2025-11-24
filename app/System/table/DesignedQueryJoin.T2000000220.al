table 2000000220 "Designed Query Join"
{
    Caption = 'Designed Query Join';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        field(1; "Query ID"; BigInteger)
        {
            Caption = 'Query ID';
        }
        field(2; "Inner Data Item"; Text[120])
        {
            Caption = 'Inner Data Item';
        }
        field(3; "Order"; Integer)
        {
            Caption = 'Order';
        }
        field(4; "Inner Field"; Text[30])
        {
            Caption = 'Inner Field';
        }
        field(5; "Outer Data Item"; Text[120])
        {
            Caption = 'Outer Data Item';
        }
        field(6; "Outer Field"; Text[30])
        {
            Caption = 'Outer Field';
        }
    }

    keys
    {
        key(PK; "Query Id", "Inner Data Item", "Order")
        {
            Clustered = true;
        }
    }
}