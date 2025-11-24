table 2000000214 "Designed Query Caption"
{
    Caption = 'Designed Query Caption';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        field(1; "Query ID"; BigInteger)
        {
            Caption = 'Query ID';
        }
        field(2; "Column"; Text[120])
        {
            Caption = 'Column';
        }
        field(3; "Language ID"; Text[250])
        {
            Caption = 'Language ID';
        }
        field(4; "Name"; Text[30])
        {
            Caption = 'Name';
        }
    }

    keys
    {
        key(PK; "Query Id", "Column", "Language ID")
        {
            Clustered = true;
        }
    }
}