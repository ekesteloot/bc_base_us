// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

/// <summary>
/// Stores user intervention suggestions for agent tasks to enable human guidance and oversight.
/// Provides structured suggestions that can be offered to agents during task execution for improved outcomes.
/// </summary>
/// <remarks>
/// Temporary table used for passing user intervention suggestions between agent metadata interfaces and the agent framework.
/// Supports both always-included suggestions and context-evaluated suggestions based on relevance.
/// Essential for human-agent collaboration and task execution improvement.
/// </remarks>
table 2000000279 "Agent Task User Int Suggestion"
{
    Caption = 'Agent Task User Intervention Suggestion';
    ReplicateData = false;
    Scope = OnPrem; // TODO(agent) - This should change to Cloud when ready to expose agents.
    TableType = Temporary;

    fields
    {
        /// <summary>
        /// Brief summary of the suggestion displayed to users in the interface.
        /// </summary>
        /// <remarks>
        /// It is recommended:
        /// - to translate this field in the agent's language (for instance, using labels),
        /// - to not end this field's value with a period.
        /// </remarks>
        field(1; "Summary"; Text[100])
        {
            Caption = 'Summary';
            Tooltip = 'A summary of the suggestion that will be displayed to users.';
        }
        /// <summary>
        /// Detailed instructions provided to the agent when this suggestion is selected.
        /// </summary>
        /// <remarks>
        /// It is recommended to use English to provide instructions.
        /// </remarks>
        field(2; "Instructions"; Text[1024])
        {
            Caption = 'Instructions';
            Tooltip = 'The instructions that will be provided to the agent if this suggestion is used.';
        }
        /// <summary>
        /// Description used by the system to evaluate suggestion relevance and applicability.
        /// </summary>
        /// <remarks>
        /// It is recommended to use English to provide the description.
        /// </remarks>
        field(3; "Description"; Text[1024])
        {
            Caption = 'Description';
            Tooltip = 'The description for this suggestion that is used to determine situations in which it may be applicable.';
        }
        /// <summary>
        /// Specifies whether this suggestion must always be included regardless of context evaluation.
        /// </summary>
        field(4; "Always Included"; Boolean)
        {
            InitValue = false;
            Caption = 'Always Included';
            ToolTip = 'Specifies whether the suggestion must always be included. If set to false, the service will evaluate its relevance based on the suggestion''s description and the current task context.';
        }
    }

    keys
    {
        key(PK; "Summary")
        {
            Clustered = true;
        }
    }
}
