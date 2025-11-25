// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

using System.Security.AccessControl;

/// <summary>
/// Virtual table that provides timeline view of agent task execution and status progression.
/// </summary>
/// <remarks>
/// This table offers a chronological view of agent task execution, showing status changes,
/// progress indicators, and key milestones throughout the task lifecycle. Essential for monitoring
/// agent task progression, debugging execution issues, and providing user-friendly status updates.
/// The timeline captures both high-level task status and detailed step information to support
/// task tracking and user experience scenarios.
/// </remarks>
table 2000000278 "Agent Task Timeline"
{
    Caption = 'Agent Task Timeline';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// The unique identifier of the agent task being tracked in this timeline.
        /// </summary>
        field(1; "Task ID"; BigInteger)
        {
            Editable = false;
            Caption = 'Task ID';
            Tooltip = 'Specifies the identifier for the agent task.';
        }
        /// <summary>
        /// The security ID of the agent user executing this task.
        /// </summary>
        field(2; "Agent User Security ID"; Guid)
        {
            Editable = false;
            Caption = 'Agent User Security ID';
            TableRelation = Agent."User Security ID";
            Tooltip = 'Specifies the unique identifier for the agent user.';
        }
        /// <summary>
        /// The security ID of the user who created this agent task.
        /// </summary>
        field(3; "Created By"; Guid)
        {
            Editable = false;
            Caption = 'Created By';
            TableRelation = User."User Security ID";
            Tooltip = 'Specifies the unique identifier for the user that created the agent task.';
        }
        /// <summary>
        /// The status indicator showing the current state of the agent task.
        /// </summary>
        field(4; "Indicator"; Enum "Agent Task Status")
        {
            Editable = false;
            Caption = 'Indicator';
            Tooltip = 'Specifies the indicator of the agent task in the timeline.';
        }
        /// <summary>
        /// A textual description of the current status of the agent task.
        /// </summary>
        field(5; "Status"; Text[100])
        {
            Editable = false;
            Caption = 'Status';
            Tooltip = 'Specifies the status of the agent task in the timeline.';
        }
        /// <summary>
        /// The timestamp when the last step was executed for this agent task.
        /// </summary>
        field(6; "Last Step Timestamp"; DateTime)
        {
            Editable = false;
            Caption = 'Last Step Timestamp';
            Tooltip = 'Specifies the timestamp of the last step executed for the agent task.';
        }
        /// <summary>
        /// The type of the current timeline step being executed.
        /// </summary>
        field(7; "Current Step Type"; Enum "Agent Task Timeline Step Type")
        {
            Editable = false;
            Caption = 'Current Step Type';
            ToolTip = 'Specifies the type of the current timeline step.';
        }
        /// <summary>
        /// A summary of the task content and purpose stored as binary data.
        /// </summary>
        field(8; "Summary"; Blob)
        {
            Caption = 'Summary';
            ToolTip = 'Specifies the summary of the task.';
        }
        /// <summary>
        /// The display title of the agent task for user interface presentation.
        /// </summary>
        field(9; "Title"; Text[150])
        {
            Editable = false;
            Caption = 'Title';
            ToolTip = 'Specifies the title of the agent task.';
        }
        /// <summary>
        /// Indicates whether the task requires user attention or intervention.
        /// </summary>
        field(10; "Needs Attention"; Boolean)
        {
            Editable = false;
            Caption = 'Needs Attention';
            ToolTip = 'Specifies whether the task needs attention.';
        }
        /// <summary>
        /// The identifier of the current timeline step for this task.
        /// </summary>
        field(11; "Current Timeline Step ID"; BigInteger)
        {
            Editable = false;
            Caption = 'Current Timeline Step ID';
            TableRelation = "Agent Task Timeline Step".ID;
            ToolTip = 'Specifies the ID of the current Agent Task Timeline Step for this task.';
        }
    }

    keys
    {
        key(PK; "Task ID")
        {
            Clustered = true;
        }
    }
}