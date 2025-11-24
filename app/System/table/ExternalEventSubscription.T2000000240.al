table 2000000240 "External Event Subscription"
{
    Caption = 'External Event Subscription';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        field(1; "ID"; Guid)
        {
            Caption = 'ID';
        }
        field(2; "App Id"; Guid)
        {
            Caption = 'App Id';
        }
        field(3; "Event Name"; Text[80])
        {
            Caption = 'Event Name';
        }
        field(4; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
        }
        field(5; "User Id"; Guid)
        {
            DataClassification = EndUserPseudonymousIdentifiers;
            Caption = 'User Id';
            TableRelation = User."User Security ID";
        }
        field(6; "Notification Url"; Text[2048])
        {
            Caption = 'Notification Url';
        }
        field(7; "Last Modified Date Time"; DateTime)
        {
            Caption = 'Last Modified Date Time';
        }
        field(8; "Client State"; Text[2048])
        {
            DataClassification = CustomerContent;
            Caption = 'Client State';
        }
        field(9; "Subscription Type"; Option)
        {
            Caption = 'Subscription Type';
            OptionCaption = 'Dataverse,Webhook';
            OptionMembers = Dataverse,Webhook;
        }
    }

    keys
    {
        key(Key1; "ID")
        {
            Clustered = true;
        }
        key(Key2; "App Id", "Event Name")
        {
        }
    }

    fieldgroups
    {
    }
}

