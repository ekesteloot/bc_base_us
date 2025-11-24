table 2000000238 "Privacy Notice Approval"
{
    Caption = 'Privacy Notice Approval';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = Cloud;

    fields
    {
        field(1; ID; Code[50])
        {
            Caption = 'Privacy Notice ID';
            TableRelation = "Privacy Notice";
        }
        field(2; "User SID"; Guid)
        {
            Caption = 'User SID';
            TableRelation = User."User Security ID";
        }
        field(3; "Approver User SID"; Guid)
        {
            Caption = 'Approver User ID';
            TableRelation = User."User Security ID";
        }
        field(4; Approved; Boolean)
        {
            Caption = 'Approved';
        }
    }

    keys
    {
        key(Key1; Id, "User SID")
        {
            Clustered = true;
        }
    }
}