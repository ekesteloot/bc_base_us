// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents.Internal;

using System.Agents;

/// <summary>
/// Stores timeline step data for agent task execution, tracking the progression and status of individual steps within an agent task.
/// </summary>
/// <remarks>
/// This internal table manages the timeline and execution steps of agent tasks, providing detailed tracking of task progression.
/// Each record represents a specific step in the agent task execution process, including title, description, status, and completion details.
/// Essential for monitoring agent task execution flow and providing detailed execution logs within the AI agent framework.
/// </remarks>
table 2000000271 "Agent Task Timeline Step Data"
{
    Caption = 'Agent Task Timeline Step Data';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;
    Access = Internal;

    fields
    {
        /// <summary>
        /// The unique identifier of the parent agent task.
        /// </summary>
        field(1; "Task ID"; BigInteger)
        {
            Caption = 'Task ID';
            TableRelation = "Agent Task Data".ID;
        }
        /// <summary>
        /// The unique identifier for this timeline step within the task.
        /// </summary>
        field(2; "ID"; BigInteger)
        {
            AutoIncrement = true;
        }
        /// <summary>
        /// The title or name of this timeline step.
        /// </summary>
        field(3; "Title"; Text[100])
        {
            Caption = 'Title';
        }
        /// <summary>
        /// A detailed description of what happened during this timeline step.
        /// </summary>
        field(4; Description; Text[2048])
        {
            ToolTip = 'A description of what happened as part of this timeline step. This is used to provide context to the user.';
        }
        /// <summary>
        /// The page ID of the primary page associated with this timeline step.
        /// </summary>
        field(5; "Primary Page ID"; Integer)
        {
            ToolTip = 'The page ID of the primary page associated with the timeline step.';
        }
        /// <summary>
        /// The record ID associated with this timeline step.
        /// </summary>
        field(6; "Primary Page Record ID"; RecordId)
        {
            ToolTip = 'The record ID associated with the timeline step.';
        }
        /// <summary>
        /// The page summary data of the primary page associated with this timeline step.
        /// </summary>
        field(7; "Primary Page Summary"; Blob)
        {
            ToolTip = 'The page summary of the primary page associated with the timeline step.';
        }
        /// <summary>
        /// The page query string of the primary page associated with this timeline step.
        /// </summary>
        field(8; "Primary Page Query"; Blob)
        {
            ToolTip = 'The page query string of the primary page associated with the timeline step.';
        }
        /// <summary>
        /// The ID of the first log entry associated with this timeline step.
        /// </summary>
        field(9; "First Log Entry ID"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = min("Agent Task Log Entry Data"."ID" where("Task ID" = field("Task ID"), "Timeline Step ID" = field(ID)));
        }
        /// <summary>
        /// The type of the first log entry associated with this timeline step.
        /// </summary>
        field(10; "First Log Entry Type"; Enum "Agent Task Log Entry Type")
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Log Entry Data".Type where("Task ID" = field("Task ID"), "ID" = field("First Log Entry ID")));
        }
        /// <summary>
        /// The ID of the last log entry associated with this timeline step.
        /// </summary>
        field(11; "Last Log Entry ID"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = max("Agent Task Log Entry Data"."ID" where("Task ID" = field("Task ID"), "Timeline Step ID" = field(ID)));
        }
        /// <summary>
        /// The type of the last log entry associated with this timeline step.
        /// </summary>
        field(12; "Last Log Entry Type"; Enum "Agent Task Log Entry Type")
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Log Entry Data".Type where("Task ID" = field("Task ID"), "ID" = field("Last Log Entry ID")));
        }
        /// <summary>
        /// The user security ID of the agent associated with the parent task.
        /// </summary>
        field(13; "Task Agent User Security ID"; Guid)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Data"."Agent User Security ID" where(ID = field("Task ID")));
        }
        /// <summary>
        /// The company name where the parent agent task is being executed.
        /// </summary>
        field(14; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Data"."Company Name" where(ID = field("Task ID")));
        }
        /// <summary>
        /// Indicates whether the parent task needs attention or manual intervention.
        /// </summary>
        field(15; "Task Needs Attention"; Boolean)
        {
            Caption = 'Task Needs Attention';
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Data"."Needs Attention" where(ID = field("Task ID")));
        }
        /// <summary>
        /// The importance level of this timeline step (Primary or Secondary).
        /// </summary>
        field(16; Importance; Option)
        {
            Caption = 'Importance';
            OptionCaption = 'Primary,Secondary';
            OptionMembers = Primary,Secondary;
        }
        /// <summary>
        /// The ID of the last user intervention request log entry for this timeline step.
        /// </summary>
        field(17; "Last User Intervention Request"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = max("Agent Task Log Entry Data"."ID" where("Task ID" = field("Task ID"),
                                                                         "Timeline Step ID" = field(ID),
                                                                         Type = const("Agent Task Log Entry Type"::"User Intervention Request")));
        }
        /// <summary>
        /// The ID of the last user intervention (request or response) log entry for this timeline step.
        /// </summary>
        field(18; "Last User Intervention"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = max("Agent Task Log Entry Data"."ID" where("Task ID" = field("Task ID"),
                                                                         "Timeline Step ID" = field(ID),
                                                                         Type = filter("Agent Task Log Entry Type"::"User Intervention Request" | "Agent Task Log Entry Type"::"User Intervention")));
        }
    }

    keys
    {
        key(PK; "Task ID", "ID")
        {
            Clustered = true;
        }
        key(PrimaryPageRecordId; "Primary Page Record ID")
        {
        }
    }
}