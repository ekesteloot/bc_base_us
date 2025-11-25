// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents.Internal;

using System.Agents;
using System.Security.AccessControl;

/// <summary>
/// Stores log entries for agent task execution, providing audit trail and debugging information for agent activities.
/// </summary>
/// <remarks>
/// This table maintains a detailed log of agent task execution events, including information, warnings, and errors.
/// Each log entry captures the execution context, user information, and detailed descriptions of agent activities.
/// Supports different log levels for filtering and categorization, and provides links to related memory entries
/// and timeline steps for task tracking. Used by the agent framework for debugging, monitoring,
/// and providing visibility into agent task execution processes.
/// </remarks>
table 2000000281 "Agent Task Log Entry Data"
{
    Caption = 'Agent Task Log Entry Data';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;
    Access = Internal;

    fields
    {
        /// <summary>
        /// Identifier of the agent task this log entry belongs to.
        /// </summary>
        field(1; "Task ID"; BigInteger)
        {
            TableRelation = "Agent Task Data".ID;
        }
        /// <summary>
        /// Unique identifier for the log entry within the task.
        /// </summary>
        field(2; "ID"; Integer)
        {
        }
        /// <summary>
        /// Security ID of the user in whose context this log entry was created.
        /// </summary>
        field(3; "User Security ID"; Guid)
        {
            TableRelation = User."User Security ID";
        }
        /// <summary>
        /// Type classification of the log entry defining its purpose and content structure.
        /// </summary>
        field(4; "Type"; Enum "Agent Task Log Entry Type")
        {
        }
        /// <summary>
        /// Detailed information for the log entry stored as BLOB for complex data structures.
        /// </summary>
        field(5; "Details"; Blob)
        {
        }
        /// <summary>
        /// Human-readable description of the logged event or activity.
        /// </summary>
        field(6; "Description"; Text[2048])
        {
        }
        /// <summary>
        /// Severity level of the log entry for filtering and prioritization.
        /// </summary>
        field(7; "Level"; Option)
        {
            OptionCaption = 'Information,Warning,Error';
            OptionMembers = Information,Warning,Error;
        }
        /// <summary>
        /// Caption of the page or UI element related to this log entry, if applicable.
        /// </summary>
        field(8; "Page Caption"; Text[150])
        {
        }
        /// <summary>
        /// Client context information stored as BLOB for the log entry.
        /// </summary>
        field(9; "Client Context"; Blob)
        {
        }
        /// <summary>
        /// ID of the memory entry this log entry is associated with for context linking.
        /// </summary>
        field(10; "Memory Entry ID"; Integer)
        {
            ToolTip = 'Specifies the memory entry this log entry is associated with.';
            TableRelation = "Agent Task Memory Entry Data"."ID";
            ValidateTableRelation = false;
        }
        /// <summary>
        /// ID of the timeline step this log entry is associated with for execution tracking.
        /// </summary>
        field(11; "Timeline Step ID"; BigInteger)
        {
            ToolTip = 'Specifies the timeline step this log entry is associated with.';
            TableRelation = "Agent Task Timeline Step Data".ID;
            ValidateTableRelation = false;
        }
        /// <summary>
        /// Security ID of the agent user for the task this log entry belongs to, calculated from the task data.
        /// </summary>
        field(12; "Task Agent User Security ID"; Guid)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Data"."Agent User Security ID" where(ID = field("Task ID")));
        }
        /// <summary>
        /// Company name context for the task this log entry belongs to, calculated from the task data.
        /// </summary>
        field(13; "Company Name"; Text[30])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Data"."Company Name" where(ID = field("Task ID")));
        }
    }

    keys
    {
        key(PK; "Task ID", "ID")
        {
            Clustered = true;
        }
        key(TaskId; "Task ID")
        {
        }
        key(TaskIdMemoryEntryId; "Task ID", "Memory Entry ID")
        {
        }
        key(TimelineStepID; "Task ID", "Timeline Step ID", "ID")
        {
        }
    }
}