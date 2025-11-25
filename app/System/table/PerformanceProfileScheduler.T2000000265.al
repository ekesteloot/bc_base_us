// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.PerformanceProfile;

using System.Security.AccessControl;

table 2000000265 "Performance Profile Scheduler"
{
    Caption = 'Performance Profile Scheduler';
    DataPerCompany = false;
    Scope = OnPrem;
    ReplicateData = false;

    fields
    {
        field(1; "Schedule ID"; Guid)
        {
        }

        field(2; "Client Type"; Option)
        {
            Caption = 'Client Type';
            OptionCaption = ',,Web Service,,,Background,,Web Client,,,,';
            OptionMembers = ,,"Web Service",,,Background,,"Web Client",,,,;
        }

        field(3; "User ID"; Guid)
        {
            Caption = 'User Id';
            TableRelation = User."User Security ID";
            DataClassification = EndUserIdentifiableInformation;
        }

        field(4; "Starting Date-Time"; DateTime)
        {
            Caption = 'Starting Date-Time';
        }

        field(5; "Ending Date-Time"; DateTime)
        {
            Caption = 'Ending Date-Time';
        }

        field(6; Description; Text[128])
        {
            Caption = 'Description';
        }

        field(7; Enabled; Boolean)
        {
            Caption = 'Enabled';
        }

        field(8; Frequency; Option)
        {
            Caption = 'Frequency';
            OptionCaption = '50 milliseconds,100 milliseconds,150 milliseconds';
            OptionMembers = "50 milliseconds","100 milliseconds","150 milliseconds";
        }

        field(9; "Profile Creation Threshold"; Duration)
        {
            Caption = 'Ignore profiles less than (milliseconds)';
        }

        field(10; "Profile Keep Time"; Integer)
        {
            Caption = 'The number of days a profile will be kept (max 7) ';
            ObsoleteState = Removed;
            ObsoleteReason = 'Not used';
        }
    }

    keys
    {
        key(PK; "Schedule ID")
        {
            Clustered = true;
        }

        key(ClienTypeUserId; "User Id", "Client Type")
        {
        }

        key(StartTimeEndTime; "Starting Date-Time", "Ending Date-Time")
        {
        }
    }
}

