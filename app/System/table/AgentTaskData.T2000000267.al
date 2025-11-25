// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents.Internal;

using System.Agents;
using System.Environment;
using System.Security.AccessControl;

/// <summary>
/// Stores task instances for AI agents, tracking their execution status, metadata, and relationships to agent definitions.
/// </summary>
/// <remarks>
/// This table manages individual task executions within the agent framework, providing task lifecycle management
/// and status tracking. Each record represents a specific task assigned to an agent with execution context,
/// status information, and links to related log entries. Supports task scheduling through the "Not Before" field
/// and maintains versioning through instruction hashes. Used by the agent runtime to manage task execution
/// and provide task monitoring capabilities.
/// </remarks>
table 2000000267 "Agent Task Data"
{
    Caption = 'Agent Task Data';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;
    Access = Internal;

    fields
    {
        /// <summary>
        /// Unique auto-incrementing identifier for the agent task.
        /// </summary>
        field(1; "ID"; BigInteger)
        {
            Caption = 'ID';
            AutoIncrement = true;
        }
        /// <summary>
        /// Security ID of the agent user responsible for executing this task.
        /// </summary>
        field(2; "Agent User Security ID"; Guid)
        {
            Caption = 'Agent User Security ID';
            TableRelation = "Agent Data"."User Security ID";
        }
        /// <summary>
        /// Security ID of the user who created this task.
        /// </summary>
        field(3; "Created By"; Guid)
        {
            Caption = 'Created By';
            TableRelation = User."User Security ID";
        }
        /// <summary>
        /// Current execution status of the agent task.
        /// </summary>
        field(4; "Status"; Enum "Agent Task Status")
        {
            Caption = 'Status';
        }
        /// <summary>
        /// Name of the company context in which this task should be executed.
        /// </summary>
        field(5; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            TableRelation = Company."Name";
        }
        /// <summary>
        /// ID of the most recent log entry for this task, calculated from the related log entries.
        /// </summary>
        field(6; "Last Log Entry ID"; Integer)
        {
            Caption = 'Last Log Entry ID';
            FieldClass = FlowField;
            CalcFormula = max("Agent Task Log Entry Data".ID where("Task ID" = field(ID)));
        }
        /// <summary>
        /// Timestamp of the most recent log entry for this task, calculated from the related log entries.
        /// </summary>
        field(7; "Last Log Entry Timestamp"; DateTime)
        {
            Caption = 'Last Log Entry Timestamp';
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Log Entry Data".SystemCreatedAt where("Task ID" = field(ID), ID = field("Last Log Entry ID")));
        }
        /// <summary>
        /// External identifier for the task used for integration with external systems.
        /// </summary>
        field(8; "External ID"; Text[2048])
        {
            Caption = 'External ID';
        }
        /// <summary>
        /// Human-readable title or description of the task.
        /// </summary>
        field(9; "Title"; Text[150])
        {
            Caption = 'Title';
        }
        /// <summary>
        /// Hash of the agent's instructions when this task was created, used for version tracking.
        /// </summary>
        field(11; "Instructions Hash"; Text[64])
        {
            Caption = 'Instructions Hash';
            ToolTip = 'The hash of the agent''s instruction when the task was created.';
        }
        /// <summary>
        /// Indicates whether the task was created with the current agent instructions, calculated by comparing instruction hashes.
        /// </summary>
        field(12; "Created With Curr Instructions"; Boolean)
        {
            Caption = 'Created With Curr Instructions';
            ToolTip = 'Specifies whether the task was created with the same instructions than the current instructions for the agent.';
            FieldClass = FlowField;
            CalcFormula = exist("Agent Data" where("User Security ID" = field("Agent User Security ID"),
                                                   "Instructions Hash" = field("Instructions Hash")));
        }
        /// <summary>
        /// Metadata provider for the agent executing this task, calculated from the agent data.
        /// </summary>
        field(13; "Agent Metadata Provider"; Enum "Agent Metadata Provider")
        {
            Caption = 'Agent Metadata Provider';
            Tooltip = 'Specifies the provider for the agent metadata.';
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Data"."Agent Metadata Provider" where("User Security ID" = field("Agent User Security ID")));
        }
        /// <summary>
        /// Indicates whether the task requires user attention or intervention.
        /// </summary>
        field(14; "Needs Attention"; Boolean)
        {
            Caption = 'Needs Attention';
            ToolTip = 'Specifies whether the task needs attention.';
            InitValue = false;
        }
        /// <summary>
        /// Type of the most recent log entry for this task, calculated from the related log entries.
        /// </summary>
        field(15; "Last Log Entry Type"; Enum "Agent Task Log Entry Type")
        {
            Caption = 'Last Log Entry Type';
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Log Entry Data".Type where("Task ID" = field(ID), "ID" = field("Last Log Entry ID")));
        }
        /// <summary>
        /// Earliest time when the task can be executed, used for task scheduling.
        /// </summary>
        field(16; "Not Before"; DateTime)
        {
            Caption = 'Not Before';
            ToolTip = 'Specifies the earliest time the task can be executed.';
        }
        /// <summary>
        /// The count of primary timeline steps associated with this task.
        /// </summary>
        field(17; "Primary Timeline Step Count"; Integer)
        {
            Caption = 'Primary Timeline Step Count';
            FieldClass = FlowField;
            CalcFormula = count("Agent Task Timeline Step Data" where("Task ID" = field(ID), Importance = const(Primary)));
        }
        /// <summary>
        /// The count of secondary timeline steps associated with this task.
        /// </summary>
        field(18; "Secondary Timeline Step Count"; Integer)
        {
            Caption = 'Secondary Timeline Step Count';
            FieldClass = FlowField;
            CalcFormula = count("Agent Task Timeline Step Data" where("Task ID" = field(ID), Importance = const(Secondary)));
        }
    }

    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
        key(AgentUserSecurityID; "Agent User Security ID")
        {
        }
        key(AgentUserSecurityIDStatus; "Agent User Security ID", Status)
        {
        }
        key(StatusCreatedAt; Status, SystemCreatedAt)
        {
        }
        key(ExternalID; "External ID")
        {
        }
        key(NeedsAttention; "Agent User Security ID", "Company Name", "Needs Attention")
        {
        }
    }
}