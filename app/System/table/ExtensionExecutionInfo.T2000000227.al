table 2000000227 "Extension Execution Info"
{
    Caption = 'Extension Execution Info';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        field(1; "Form ID"; Guid)
        {
            Caption = 'Form ID';
        }

        field(2; "Runtime Package ID"; Guid)
        {
            Caption = 'Runtime Package ID';
        }

        field(3; "Execution Time"; Integer)
        {
            Caption = 'Execution time';
        }

        field(4; "Subscriber Execution Count"; Integer)
        {
            Caption = 'Subscriber execution count';
        }
    }

    keys
    {
        key(PK; "Form ID", "Runtime Package ID")
        {
            Clustered = true;
        }
    }
}