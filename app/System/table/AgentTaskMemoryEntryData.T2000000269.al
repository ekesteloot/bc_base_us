// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents.Internal;

using System.Agents;
using System.Security.AccessControl;

/// <summary>
/// Stores memory entries for agent tasks, providing context and state management for agent execution.
/// </summary>
/// <remarks>
/// This table implements the memory system for agent tasks, storing contextual information that agents
/// can reference during task execution. Memory entries capture important state, decisions, and context
/// that need to persist across task execution steps. Supports different memory entry types and stores
/// both user-visible details and internal runtime information. Used by the agent framework to maintain
/// execution context and enable sophisticated agent behaviors that require memory and context awareness.
/// </remarks>
table 2000000269 "Agent Task Memory Entry Data"
{
    Caption = 'Agent Task Memory Entry Data';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;
    Access = Internal;

    fields
    {
        /// <summary>
        /// Identifier of the agent task this memory entry belongs to.
        /// </summary>
        field(1; "Task ID"; BigInteger)
        {
            Caption = 'Task ID';
            TableRelation = "Agent Task Data".ID;
        }
        /// <summary>
        /// Unique identifier for the memory entry within the task.
        /// </summary>
        field(2; "ID"; Integer)
        {
        }
        /// <summary>
        /// Security ID of the user associated with this memory entry.
        /// </summary>
        field(3; "User Security ID"; Guid)
        {
            Caption = 'User Security ID';
            TableRelation = User."User Security ID";
        }
        /// <summary>
        /// Type classification of the memory entry defining its purpose and content structure.
        /// </summary>
        field(4; "Type"; Enum "Agent Task Memory Entry Type")
        {
            Caption = 'Type';
        }
        /// <summary>
        /// Detailed information for the memory entry stored as BLOB.
        /// </summary>
        field(5; "Details"; Blob)
        {
        }
        /// <summary>
        /// Human-readable description of the memory entry.
        /// </summary>
        field(6; Description; Text[2048])
        {
        }
        /// <summary>
        /// Security ID of the agent user for the task this memory entry belongs to, calculated from the task data.
        /// </summary>
        field(7; "Task Agent User Security ID"; Guid)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Data"."Agent User Security ID" where(ID = field("Task ID")));
        }
        /// <summary>
        /// Internal runtime details for the memory entry not exposed to end users.
        /// </summary>
        field(8; "Internal Details"; Blob)
        {
            ToolTip = 'Specifies the internal details of the entry. These are used by the agent runtime and should not be exposed.';
        }
        /// <summary>
        /// Optional record reference related to this memory entry for data correlation.
        /// </summary>
        field(9; "Related Record ID"; RecordId)
        {
            ToolTip = 'Specifies the optional record related to this memory entry, e.g. an incoming message, a record created by the agent, etc.';
        }
        /// <summary>
        /// Company name context for the task this memory entry belongs to, calculated from the task data.
        /// </summary>
        field(10; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Data"."Company Name" where(ID = field("Task ID")));
        }
        /// <summary>
        /// Execution context data capturing the task state when this memory entry was created.
        /// </summary>
        field(11; "Context"; Blob)
        {
            Caption = 'Context';
            ToolTip = 'Specifies the context of the entry. It contains data about the state of the task''s execution when the entry was saved.';
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

        key(TaskIdType; "Task ID", "Type", "ID")
        {
            Unique = false;
            SqlIndex = "Task ID", "Type", "ID";
        }
    }
}