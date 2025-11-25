// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.PerformanceProfile;

using System.Security.AccessControl;

/// <summary>
/// Stores scheduling configuration for performance profiling sessions, managing when and how performance data is collected.
/// </summary>
/// <remarks>
/// This table manages the scheduling and configuration of performance profiling sessions within Business Central.
/// Each record defines a specific profiling schedule with time windows, user filters, and client type restrictions.
/// Essential for systematic performance monitoring, allowing targeted data collection during specific periods or user activities.
/// </remarks>
table 2000000265 "Performance Profile Scheduler"
{
    Caption = 'Performance Profile Scheduler';
    DataPerCompany = false;
    Scope = OnPrem;
    ReplicateData = false;

    fields
    {
        /// <summary>
        /// The unique identifier for this performance profiling schedule.
        /// </summary>
        field(1; "Schedule ID"; Guid)
        {
        }
        /// <summary>
        /// The type of client connection that this profiling schedule applies to.
        /// </summary>
        field(2; "Client Type"; Option)
        {
            Caption = 'Client Type';
            OptionCaption = ',,Web Service,,,Background,,Web Client,,,,';
            OptionMembers = ,,"Web Service",,,Background,,"Web Client",,,,;
        }
        /// <summary>
        /// The security ID of the user whose activities should be profiled, or empty for all users.
        /// </summary>
        field(3; "User ID"; Guid)
        {
            Caption = 'User Id';
            TableRelation = User."User Security ID";
            DataClassification = EndUserIdentifiableInformation;
        }
        /// <summary>
        /// The date and time when performance profiling should begin for this schedule.
        /// </summary>
        field(4; "Starting Date-Time"; DateTime)
        {
            Caption = 'Starting Date-Time';
        }
        /// <summary>
        /// The date and time when performance profiling should end for this schedule.
        /// </summary>
        field(5; "Ending Date-Time"; DateTime)
        {
            Caption = 'Ending Date-Time';
        }
        /// <summary>
        /// A descriptive name or purpose for this performance profiling schedule.
        /// </summary>
        /// <summary>
        /// A descriptive name or purpose for this performance profiling schedule.
        /// </summary>
        field(6; Description; Text[128])
        {
            Caption = 'Description';
        }
        /// <summary>
        /// Indicates whether this performance profiling schedule is currently active and should be executed.
        /// </summary>
        field(7; Enabled; Boolean)
        {
            Caption = 'Enabled';
        }
        /// <summary>
        /// The sampling frequency for performance data collection, determining how often profiling data is captured.
        /// </summary>
        field(8; Frequency; Option)
        {
            Caption = 'Frequency';
            OptionCaption = '50 milliseconds,100 milliseconds,150 milliseconds';
            OptionMembers = "50 milliseconds","100 milliseconds","150 milliseconds";
        }
        /// <summary>
        /// The minimum duration threshold for creating performance profiles, filtering out very short operations.
        /// </summary>
        field(9; "Profile Creation Threshold"; Duration)
        {
            Caption = 'Ignore profiles less than (milliseconds)';
        }
        /// <summary>
        /// Obsolete field for profile retention time management, no longer used in current implementation.
        /// </summary>
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

