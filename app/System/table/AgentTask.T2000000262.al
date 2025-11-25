// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

using System.Environment;
using System.Security.AccessControl;

/// <summary>
/// Virtual table that provides information about tasks created for and executed by AI agents in the system.
/// This table enables tracking, monitoring, and management of agent task execution and status.
/// </summary>
/// <remarks>
/// The Agent Task table is central to the AI agent framework in Business Central, providing comprehensive
/// task management capabilities for automated agents. It tracks task creation, execution status, ownership,
/// and various task attributes including external identifiers for integration with other systems like
/// Outlook or Teams. This table enables monitoring of agent performance, task completion rates, and
/// identifying tasks that require human attention or intervention. The table includes audit trails
/// showing who created tasks and detailed logging information for troubleshooting and compliance purposes.
/// Currently scoped for on-premises deployments during the preview phase.
/// </remarks>
table 2000000262 "Agent Task"
{
    Caption = 'Agent Task';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem; // TODO(agent) - This should change to Cloud when ready to expose agents.

    fields
    {
        /// <summary>
        /// The unique identifier for the agent task.
        /// </summary>
        field(1; "ID"; BigInteger)
        {
            Caption = 'ID';
            Editable = false;
            Tooltip = 'Specifies the identifier for the agent task.';
        }
        /// <summary>
        /// The security identifier of the agent user assigned to execute this task.
        /// </summary>
        field(2; "Agent User Security ID"; Guid)
        {
            Caption = 'Agent User Security ID';
            Editable = false;
            TableRelation = Agent."User Security ID";
            Tooltip = 'Specifies the unique identifier for the agent user.';
        }
        /// <summary>
        /// The security identifier of the user who created this agent task.
        /// </summary>
        field(3; "Created By"; Guid)
        {
            Caption = 'Created By';
            Editable = false;
            TableRelation = User."User Security ID";
            Tooltip = 'Specifies the unique identifier for the user that created the agent task.';
        }
        /// <summary>
        /// The current execution status of the agent task.
        /// </summary>
        field(4; "Status"; Enum "Agent Task Status")
        {
            Caption = 'Status';
            Tooltip = 'Specifies the status of the agent task.';
        }
        /// <summary>
        /// The name of the company context in which this agent task operates.
        /// </summary>
        field(5; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            Editable = false;
            TableRelation = Company."Name";
            Tooltip = 'Specifies the company name for the agent task.';
        }
        /// <summary>
        /// The identifier of the most recent log entry recorded for this task.
        /// </summary>
        field(6; "Last Log Entry ID"; Integer)
        {
            Caption = 'Last Log Entry ID';
            Editable = false;
            Tooltip = 'Specifies ID of the last log entry recorded for the agent task.';
        }
        /// <summary>
        /// The timestamp when the most recent log entry was recorded for this task.
        /// </summary>
        field(7; "Last Log Entry Timestamp"; DateTime)
        {
            Caption = 'Last Log Entry Timestamp';
            Editable = false;
            Tooltip = 'Specifies the timestamp of the last log entry recorded for the agent task.';
        }
        /// <summary>
        /// The user name of the agent assigned to this task, retrieved from the Agent table.
        /// </summary>
        field(8; "Agent User Name"; Code[50])
        {
            Caption = 'Agent User Name';
            Tooltip = 'Specifies the name of the user that is associated with the agent.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Agent"."User Name" where("User Security ID" = field("Agent User Security ID")));
        }
        /// <summary>
        /// The display name of the agent assigned to this task, retrieved from the Agent table.
        /// </summary>
        field(9; "Agent Display Name"; Text[80])
        {
            Caption = 'Agent Display Name';
            Tooltip = 'Specifies the display name of the user that is associated with the agent.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Agent"."Display Name" where("User Security ID" = field("Agent User Security ID")));
        }
        /// <summary>
        /// The user name of the person who created this agent task, retrieved from the User table.
        /// </summary>
        field(10; "Created By User Name"; Code[50])
        {
            Caption = 'Created By User Name';
            Tooltip = 'Specifies the name of the user that created the agent task.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("User"."User Name" where("User Security ID" = field("Created By")));
        }
        /// <summary>
        /// The full name of the person who created this agent task, retrieved from the User table.
        /// </summary>
        field(11; "Created By Full Name"; Text[80])
        {
            Caption = 'Created By Full Name';
            Tooltip = 'Specifies the full name of the user that created the agent task.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("User"."Full Name" where("User Security ID" = field("Created By")));
        }
        /// <summary>
        /// External system identifier for integration with other platforms such as Outlook or Teams conversations.
        /// </summary>
        field(12; "External ID"; Text[2048])
        {
            Caption = 'External ID';
            Tooltip = 'Specifies the external identifier related to the agent task, such as an Outlook or Teams conversation identifier.';
        }
        /// <summary>
        /// The descriptive title or name of the agent task.
        /// </summary>
        field(13; "Title"; Text[150])
        {
            Caption = 'Title';
            ToolTip = 'Specifies the title of the agent task.';
        }
        /// <summary>
        /// Indicates whether this task was created using the current instruction set for the agent.
        /// </summary>
#pragma warning disable AL0468 // Virtual tables are not prone to SQL table name length issues
        field(14; "Created With Current Instructions"; Boolean)
#pragma warning restore AL0468
        {
            Editable = false;
            Caption = 'Created With Current Instructions';
            ToolTip = 'Specifies whether the task was created with the same instructions than the current instructions for the agent.';
        }
        /// <summary>
        /// Indicates whether this task requires human attention or intervention to proceed.
        /// </summary>
        field(15; "Needs Attention"; Boolean)
        {
            Caption = 'Needs Attention';
            ToolTip = 'Specifies whether the task needs attention.';
        }
    }

    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }
}