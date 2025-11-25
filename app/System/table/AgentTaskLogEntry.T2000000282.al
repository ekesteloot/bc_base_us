// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

using System.Security.AccessControl;

/// <summary>
/// Virtual table that stores log entries generated during agent task execution.
/// </summary>
/// <remarks>
/// This table provides logging and audit trail for agent task activities, capturing
/// information, warnings, and errors that occur during task execution. Essential for debugging,
/// monitoring, and troubleshooting agent operations. Each log entry includes details about the user
/// context, severity level, and associated memory entries for complete traceability.
/// The table is scoped to OnPrem and not replicated for security and performance considerations.
/// </remarks>
table 2000000282 "Agent Task Log Entry"
{
    Caption = 'Agent Task Log Entry';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// The unique identifier of the agent task that generated this log entry.
        /// </summary>
        field(1; "Task ID"; BigInteger)
        {
            Caption = 'Task ID';
            ToolTip = 'Specifies the unique identifier of the task this log entry is a part of.';
            Editable = false;
            TableRelation = "Agent Task".ID;
        }
        /// <summary>
        /// The sequential identifier of this log entry within the task.
        /// </summary>
        field(2; "ID"; Integer)
        {
            Caption = 'ID';
            Editable = false;
        }
        /// <summary>
        /// The security ID of the user associated with this log entry.
        /// </summary>
        field(3; "User Security ID"; Guid)
        {
            Caption = 'User Security ID';
            ToolTip = 'Specifies the security ID of the user that was involved in the log entry.';
            Editable = false;
            TableRelation = User."User Security ID";
        }
        /// <summary>
        /// The type category of the log entry indicating its nature or source.
        /// </summary>
        field(4; "Type"; Enum "Agent Task Log Entry Type")
        {
            Caption = 'Type';
            ToolTip = 'Specifies the log entry type.';
            Editable = false;
        }
        /// <summary>
        /// Additional detailed information about the log entry stored as binary data.
        /// </summary>
        field(5; "Details"; Blob)
        {
            Caption = 'Details';
            ToolTip = 'Specifies additional details of the log entry.';
        }
        /// <summary>
        /// A descriptive text explaining what occurred in this log entry.
        /// </summary>
        field(6; "Description"; Text[2048])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the description of the log entry.';
        }
        /// <summary>
        /// The severity level of the log entry (Information, Warning, or Error).
        /// </summary>
        field(7; "Level"; Option)
        {
            Caption = 'Level';
            ToolTip = 'Specifies the level of the log entry.';
            OptionCaption = 'Information,Warning,Error';
            OptionMembers = Information,Warning,Error;
        }
        /// <summary>
        /// The caption of the page associated with this log entry, if applicable.
        /// </summary>
        field(8; "Page Caption"; Text[150])
        {
            Caption = 'Page Caption';
            ToolTip = 'Specifies the caption of the page associated with the log entry, if any.';
        }
        /// <summary>
        /// The full name of the user who was involved in generating this log entry.
        /// </summary>
        field(9; "User Full Name"; Text[80])
        {
            Caption = 'User Full Name';
            Tooltip = 'Specifies the full name of the user that was involved in the log entry.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("User"."Full Name" where("User Security ID" = field("User Security ID")));
        }
        /// <summary>
        /// The identifier of the memory entry associated with this log entry, if any.
        /// </summary>
        field(10; "Memory Entry ID"; Integer)
        {
            Caption = 'Memory Entry ID';
            ToolTip = 'Specifies the memory entry this log entry is associated with.';
        }
    }

    keys
    {
        key(PK; "Task ID", "ID")
        {
            Clustered = true;
        }
    }
}