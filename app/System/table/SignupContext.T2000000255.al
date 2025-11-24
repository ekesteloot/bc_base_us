table 2000000255 "Signup Context"
{
    Caption = 'Signup Context';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = Cloud;

    fields
    {
        field(1; KeyName; Text[128])
        {
            Caption = 'Key';
        }
        field(2; Value; Text[2000])
        {
            Caption = 'Value';
        }
    }

    keys
    {
        key(Key1; KeyName)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}