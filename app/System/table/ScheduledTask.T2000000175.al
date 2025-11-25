// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment;

using System.Reflection;

/// <summary>
/// Manages scheduled task execution in Business Central, storing task metadata, execution context, and failure handling information.
/// </summary>
/// <remarks>
/// This table stores scheduled tasks that can be executed at specific times or intervals within Business Central.
/// Each task includes execution context (user, company, language), timing constraints, and references to
/// codeunits for both successful execution and failure handling. Supports timeout management, authentication
/// delegation, and maintains execution state and error information. Used by the task scheduler framework
/// to manage background task execution and provide reliable task processing capabilities.
/// </remarks>
table 2000000175 "Scheduled Task"
{
    Caption = 'Scheduled Task';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// Unique identifier for the scheduled task.
        /// </summary>
        field(1; ID; Guid)
        {
            Caption = 'ID';
        }
        /// <summary>
        /// Security ID of the user under whose context the task will execute.
        /// </summary>
        field(2; "User ID"; Guid)
        {
            Caption = 'User ID';
        }
        /// <summary>
        /// Name of the user under whose context the task will execute.
        /// </summary>
        field(3; "User Name"; Text[50])
        {
            Caption = 'User Name';
        }
        /// <summary>
        /// Language ID for the user context in which the task will execute.
        /// </summary>
        field(4; "User Language ID"; Integer)
        {
            Caption = 'User Language ID';
        }
        /// <summary>
        /// Format ID for the user context in which the task will execute.
        /// </summary>
        field(5; "User Format ID"; Integer)
        {
            Caption = 'User Format ID';
        }
        /// <summary>
        /// Time zone setting for the user context in which the task will execute.
        /// </summary>
        field(6; "User Time Zone"; Text[32])
        {
            Caption = 'User Time Zone';
        }
        /// <summary>
        /// Application ID associated with the user context for the task execution.
        /// </summary>
        field(7; "User App ID"; Text[20])
        {
            Caption = 'User App ID';
        }
        /// <summary>
        /// Company context in which the scheduled task will execute.
        /// </summary>
        field(10; Company; Text[30])
        {
            Caption = 'Company';
            TableRelation = System.Environment.Company.Name;
        }
        /// <summary>
        /// Indicates whether the task is ready for execution.
        /// </summary>
        field(11; "Is Ready"; Boolean)
        {
            Caption = 'Is Ready';
        }
        /// <summary>
        /// Earliest date and time when the task should be executed.
        /// </summary>
        field(12; "Not Before"; DateTime)
        {
            Caption = 'Not Before';
        }
        /// <summary>
        /// ID of the codeunit that will be executed when the task runs.
        /// </summary>
        field(20; "Run Codeunit"; Integer)
        {
            Caption = 'Run Codeunit';
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Codeunit));
        }
        /// <summary>
        /// ID of the codeunit that will be executed if the task fails.
        /// </summary>
        field(21; "Failure Codeunit"; Integer)
        {
            Caption = 'Failure Codeunit';
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Codeunit));
        }
        /// <summary>
        /// Record reference that the task will operate on, if applicable.
        /// </summary>
        field(22; "Record"; RecordID)
        {
            Caption = 'Record';
        }
        /// <summary>
        /// Maximum duration allowed for task execution before timeout.
        /// </summary>
        field(23; "Timeout"; Duration)
        {
            Caption = 'Timeout';
        }
        /// <summary>
        /// Identifier of the tenant where this task should execute.
        /// </summary>
        field(24; "Tenant ID"; Text[128])
        {
            Caption = 'Tenant ID';
        }
        /// <summary>
        /// Error information from the last failed execution attempt.
        /// </summary>
        field(25; "Last Error"; BLOB)
        {
            Caption = 'Last Error';
        }
        /// <summary>
        /// Record reference for authentication delegation, if used.
        /// </summary>
        field(26; "Auth Delegation Related Record"; RecordId)
        {
            Caption = 'Delegation Related Record';
        }
        /// <summary>
        /// Type of authentication delegation to use for the task execution.
        /// </summary>
        field(27; "Auth Delegation Type"; Enum "Scheduled Task Auth Delegation Type")
        {
            Caption = 'Delegation Type';
        }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
        key(Key2; "Record")
        {
        }
        key(Key3; "Tenant ID", "Not Before")
        {
        }
    }

    fieldgroups
    {
    }
}

