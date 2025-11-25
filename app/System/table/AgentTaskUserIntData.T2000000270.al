// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents.Internal;

using System.Agents;

/// <summary>
/// Stores user intervention data associated with agent tasks, tracking when human input is required during task execution.
/// </summary>
/// <remarks>
/// This internal table manages user intervention requests within the agent task execution framework. 
/// It tracks pending interventions, associated memory entries, and completion status for agent tasks requiring human input.
/// Used by the AI agent system to handle scenarios where automated task execution requires manual user decisions or approvals.
/// </remarks>
table 2000000270 "Agent Task User Int. Data"
{
    Caption = 'Agent Task User Intervention Data';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;
    Access = Internal;

    fields
    {
        /// <summary>
        /// The unique identifier of the agent task requiring user intervention.
        /// </summary>
        field(1; "Task ID"; BigInteger)
        {
            Caption = 'Task ID';
            TableRelation = "Agent Task Data".ID;
        }
        /// <summary>
        /// The memory entry identifier associated with this user intervention request.
        /// </summary>
        field(2; "Memory Entry ID"; Integer)
        {
            ToolTip = 'Specifies the memory entry this user intervention is associated with.';
            TableRelation = "Agent Task Memory Entry Data"."ID";
        }
        /// <summary>
        /// Indicates whether the user intervention is still pending completion.
        /// </summary>
        field(3; "Is Pending"; Boolean)
        {
            InitValue = true;
        }
#pragma warning disable AS0004
        /// <summary>
        /// The type of user intervention request being made.
        /// </summary>
        field(4; "Intervention Request Type"; Enum "Agent User Int Request Type")
#pragma warning restore AS0004
        {
        }
        /// <summary>
        /// The ID of the record related to this user intervention, if any.
        /// </summary>
        field(5; "Related Record ID"; RecordId)
        {
            ToolTip = 'Specifies the optional record related to this user intervention.';
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Memory Entry Data"."Related Record ID" where("Task ID" = field("Task ID"), "ID" = field("Memory Entry ID")));
        }
    }

    keys
    {
        key(PK; "Task ID", "Memory Entry ID")
        {
            Clustered = true;
        }
        key(TaskID; "Task ID")
        {
        }
    }
}