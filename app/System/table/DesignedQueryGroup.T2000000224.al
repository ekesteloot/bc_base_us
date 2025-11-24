table 2000000224 "Designed Query Group"
{
    Caption = 'Designed Query Group';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        field(1; "Query ID"; BigInteger)
        {
            Caption = 'Query ID';
        }
        
        field(2; "Group"; Text[100])
        {
            Caption = 'Group';
        }
    }

    keys
    {
        key(PK; "Query Id", "Group")
        {
            Clustered = true;
        }
    }
}