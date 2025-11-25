// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

using System.Security.AccessControl;

/// <summary>
/// Virtual table that stores memory entries for agent tasks to maintain context and state information.
/// </summary>
/// <remarks>
/// This table provides persistent memory storage for agent tasks, enabling agents to maintain context,
/// remember previous interactions, and store intermediate state information for a given task execution.
/// The table includes both structured details and contextual information to support various memory scenarios.
/// Scoped to OnPrem for internal use only, ensuring secure storage of agent memory data.
/// </remarks>
table 2000000264 "Agent Task Memory Entry"
{
    Caption = 'Agent Task Memory Entry';
    DataPerCompany = false;
    Scope = OnPrem; // This virtual table is for internal use only

    fields
    {
        /// <summary>
        /// The unique identifier of the agent task that this memory entry belongs to.
        /// </summary>
        field(1; "Task ID"; BigInteger)
        {
            Caption = 'Task ID';
            ToolTip = 'Specifies the unique identifier of the task this entry is a part of.';
            Editable = false;
            TableRelation = "Agent Task".ID;
        }
        /// <summary>
        /// The sequential identifier of this memory entry within the task.
        /// </summary>
        field(2; "ID"; Integer)
        {
            Caption = 'ID';
            ToolTip = 'Specifies the entry id.';
            Editable = false;
        }
        /// <summary>
        /// The security ID of the user associated with this memory entry.
        /// </summary>
        field(3; "User Security ID"; Guid)
        {
            Caption = 'User Security ID';
            ToolTip = 'Specifies the security ID of the user that was involved in the entry.';
            Editable = false;
            TableRelation = User."User Security ID";
        }
        /// <summary>
        /// The type category of this memory entry indicating its nature or purpose.
        /// </summary>
        field(4; "Type"; Enum "Agent Task Memory Entry Type")
        {
            Caption = 'Type';
            ToolTip = 'Specifies the type of entry.';
            Editable = false;
        }
        /// <summary>
        /// Detailed information about the memory entry stored as binary data.
        /// </summary>
        field(5; "Details"; Blob)
        {
            Caption = 'Details';
            ToolTip = 'Specifies the entry details.';
        }
        /// <summary>
        /// A descriptive text explaining the content or purpose of this memory entry.
        /// </summary>
        field(6; Description; Text[2048])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the description of the entry.';
        }
        /// <summary>
        /// The full name of the user who was involved in creating this memory entry.
        /// </summary>
        field(7; "User Full Name"; Text[80])
        {
            Caption = 'User Full Name';
            Tooltip = 'Specifies the full name of the user that was involved in the entry.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("User"."Full Name" where("User Security ID" = field("User Security ID")));
        }
        /// <summary>
        /// Contextual data about the agent's state when this memory entry was created.
        /// </summary>
        field(8; "Context"; Blob)
        {
            Caption = 'Context';
            ToolTip = 'Specifies the context of the entry. It contains contextual data about the state of the agent when the entry was saved.';
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