// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

/// <summary>
/// Stores detailed information for agent user intervention requests including task context and target specifications.
/// Provides structured data for requesting human intervention during agent task execution.
/// </summary>
/// <remarks>
/// Temporary table used for passing user intervention request details between agent metadata interfaces and the agent framework.
/// Contains task identification, page context, and record targeting information for precise intervention requests.
/// Essential for enabling targeted human oversight and guidance during agent operations.
/// </remarks>
table 2000000286 "Agent User Int Request Details"
{
    Caption = 'Agent Task User Intervention Request Details';
    ReplicateData = false;
    Scope = OnPrem; // TODO(agent) - This should change to Cloud when ready to expose agents.
    TableType = Temporary;

    fields
    {
        /// <summary>
        /// Unique identifier for the agent user requesting intervention.
        /// </summary>
        field(1; "Agent User ID"; Guid)
        {
            Caption = 'Agent User ID';
        }
        /// <summary>
        /// Identifier for the specific agent task requiring user intervention.
        /// </summary>
        field(2; "Task ID"; BigInteger)
        {
            Caption = 'Task ID';
        }
        /// <summary>
        /// Type of user intervention request being made by the agent.
        /// </summary>
        field(3; "Type"; Enum "Agent User Int Request Type")
        {
            Caption = 'Type';
            ToolTip = 'Specifies the user intervention request type.';
        }
        /// <summary>
        /// Page identifier where the user intervention is requested.
        /// </summary>
        field(4; "Page ID"; Integer)
        {
            Caption = 'Page ID';
            Tooltip = 'Specifies the ID of the page the intervention request is intended for.';
        }
        /// <summary>
        /// Record identifier for the specific record requiring user intervention.
        /// </summary>
        field(5; "Record ID"; RecordId)
        {
            Caption = 'Record ID';
            Tooltip = 'Specifies the ID of the record the intervention request is intended for.';
        }
    }

    keys
    {
        key(PK; "Agent User ID", "Task ID", Type)
        {
            Clustered = true;
        }
    }
}
