// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.PerformanceProfile;
using System.Security.AccessControl;

table 2000000266 "Performance Profiles"
{
    Caption = 'Performance Profiles';
    DataPerCompany = false;
    Scope = OnPrem;
    ReplicateData = false;

    fields
    {
        field(1; "Profile ID"; BigInteger)
        {
            Caption = 'Profile ID';
            AutoIncrement = true;
        }

        field(2; "Schedule ID"; Guid)
        {
            Caption = 'Schedule ID';
            TableRelation = "Performance Profile Scheduler"."Schedule ID";
        }

        field(3; "Activity ID"; Text[32])
        {
            Caption = 'Activity ID';
        }

        field(4; "Activity Description"; Text[512])
        {
            Caption = 'Activity Description';
        }

        field(5; "Object Type"; Option)
        {
            Caption = 'Activity Object Type';
            OptionCaption = ',Table,,Report,,Codeunit,XMLport,,Page,Query,,,,,,,,,,,,,,';
            OptionMembers = ,"Table",,"Report",,"Codeunit","XMLport",,"Page","Query",,,,,,,,,,,,,;
        }

        field(6; "Object ID"; Integer)
        {
            Caption = 'Activity Object ID';
        }

        field(7; "Declaring App"; Text[256])
        {
            Caption = 'Declaring application';
        }

        field(8; "Duration"; Duration)
        {
            Caption = 'Sampling Duration';
        }

        field(9; "Http Call Duration"; Duration)
        {
            Caption = 'Http Call Duration';
        }

        field(10; "Http Call Number"; Integer)
        {
            Caption = 'Http Call Number';
        }

        field(11; "Client Session ID"; Guid)
        {
            Caption = 'Client session id';
        }

        field(12; Profile; BLOB)
        {
            Caption = 'Profile';
        }

        field(13; "Starting Date-Time"; DateTime)
        {
            Caption = 'Starting Date-Time';
        }

        field(14; "Object Display Name"; Text[256])
        {
            Caption = 'Object Display Name';
        }

        field(15; "User ID"; Guid)
        {
            Caption = 'User ID';
            DataClassification = EndUserPseudonymousIdentifiers;
        }

        field(16; "User Name"; Code[50])
        {
            Caption = 'User Name';
            FieldClass = FlowField;
            CalcFormula = lookup(User."User Name" where("User Security ID" = field("User ID")));
        }

        field(17; "Client Type"; Option)
        {
            Caption = 'Client Type';
            OptionCaption = ',,Web Service,,,Background,,Web Client,,,,';
            OptionMembers = ,,"Web Service",,,Background,,"Web Client",,,,;
            FieldClass = FlowField;
            CalcFormula = lookup("Performance Profile Scheduler"."Client Type" where("Schedule ID" = field("Schedule ID")));
        }

        field(18; "Activity Duration"; Duration)
        {
            Caption = 'Activity Duration';
        }
    }

    keys
    {
        key(PK; "Profile ID")
        {
            Clustered = true;
        }

        key(ScheduleID; "Schedule ID")
        {
        }

        key(ClientSessionID; "Client Session ID")
        {
        }
    }
}

