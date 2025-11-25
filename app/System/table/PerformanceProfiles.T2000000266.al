// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.PerformanceProfile;
using System.Security.AccessControl;

/// <summary>
/// Stores performance profiling data collected during system operation, tracking resource usage and execution metrics.
/// </summary>
/// <remarks>
/// This table captures detailed performance metrics for activities, procedures, and object executions within Business Central.
/// Each record represents a specific performance measurement with timing, resource usage, and execution context information.
/// Essential for performance analysis, optimization efforts, and system monitoring in production environments.
/// </remarks>
table 2000000266 "Performance Profiles"
{
    Caption = 'Performance Profiles';
    DataPerCompany = false;
    Scope = OnPrem;
    ReplicateData = false;

    fields
    {
        /// <summary>
        /// The unique identifier for this performance profile record.
        /// </summary>
        field(1; "Profile ID"; BigInteger)
        {
            Caption = 'Profile ID';
            AutoIncrement = true;
        }
        /// <summary>
        /// The identifier of the performance profiling schedule that collected this data.
        /// </summary>
        field(2; "Schedule ID"; Guid)
        {
            Caption = 'Schedule ID';
            TableRelation = "Performance Profile Scheduler"."Schedule ID";
        }
        /// <summary>
        /// The unique identifier of the activity being profiled.
        /// </summary>
        field(3; "Activity ID"; Text[32])
        {
            Caption = 'Activity ID';
        }
        /// <summary>
        /// A descriptive text explaining the nature of the activity being profiled.
        /// </summary>
        field(4; "Activity Description"; Text[512])
        {
            Caption = 'Activity Description';
        }
        /// <summary>
        /// The type of object associated with the profiled activity.
        /// </summary>
        field(5; "Object Type"; Option)
        {
            Caption = 'Activity Object Type';
            OptionCaption = ',Table,,Report,,Codeunit,XMLport,,Page,Query,,,,,,,,,,,,,,';
            OptionMembers = ,"Table",,"Report",,"Codeunit","XMLport",,"Page","Query",,,,,,,,,,,,,;
        }
        /// <summary>
        /// The identifier of the object associated with the profiled activity.
        /// </summary>
        field(6; "Object ID"; Integer)
        {
            Caption = 'Activity Object ID';
        }
        /// <summary>
        /// The name of the application that declared the object being profiled.
        /// </summary>
        field(7; "Declaring App"; Text[256])
        {
            Caption = 'Declaring application';
        }
        /// <summary>
        /// The duration for which the profiling data was sampled.
        /// </summary>
        field(8; "Duration"; Duration)
        {
            Caption = 'Sampling Duration';
        }
        /// <summary>
        /// The duration of HTTP calls made during the activity, if applicable.
        /// </summary>
        field(9; "Http Call Duration"; Duration)
        {
            Caption = 'Http Call Duration';
        }
        /// <summary>
        /// The number of HTTP calls made during the activity, if applicable.
        /// </summary>
        field(10; "Http Call Number"; Integer)
        {
            Caption = 'Http Call Number';
        }
        /// <summary>
        /// The identifier of the client session during which the activity was profiled.
        /// </summary>
        field(11; "Client Session ID"; Guid)
        {
            Caption = 'Client session id';
        }
        /// <summary>
        /// The binary large object containing the profile data.
        /// </summary>
        field(12; Profile; BLOB)
        {
            Caption = 'Profile';
        }
        /// <summary>
        /// The date and time when the profiling data collection started.
        /// </summary>
        field(13; "Starting Date-Time"; DateTime)
        {
            Caption = 'Starting Date-Time';
        }
        /// <summary>
        /// The display name of the object being profiled, for easier identification.
        /// </summary>
        field(14; "Object Display Name"; Text[256])
        {
            Caption = 'Object Display Name';
        }
        /// <summary>
        /// The unique identifier of the user under whom the activity was performed.
        /// </summary>
        field(15; "User ID"; Guid)
        {
            Caption = 'User ID';
            DataClassification = EndUserPseudonymousIdentifiers;
        }
        /// <summary>
        /// The name of the user who performed the activity, if available.
        /// </summary>
        field(16; "User Name"; Code[50])
        {
            Caption = 'User Name';
            FieldClass = FlowField;
            CalcFormula = lookup(User."User Name" where("User Security ID" = field("User ID")));
        }
        /// <summary>
        /// The type of client used to perform the activity (e.g., Web Service, Background, Web Client).
        /// </summary>
        field(17; "Client Type"; Option)
        {
            Caption = 'Client Type';
            OptionCaption = ',,Web Service,,,Background,,Web Client,,,,';
            OptionMembers = ,,"Web Service",,,Background,,"Web Client",,,,;
            FieldClass = FlowField;
            CalcFormula = lookup("Performance Profile Scheduler"."Client Type" where("Schedule ID" = field("Schedule ID")));
        }
        /// <summary>
        /// The duration of the activity itself, as opposed to the entire profiling period.
        /// </summary>
        field(18; "Activity Duration"; Duration)
        {
            Caption = 'Activity Duration';
        }

        field(19; "Sql Call Duration"; Duration)
        {
            Caption = 'Sql Call Duration';
        }

        field(20; "Sql Statement Number"; Integer)
        {
            Caption = 'Number of Sql Statements';
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

