// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

interface IAgentMetadata
{
    Scope = OnPrem; // TODO(agent) - This should change to Cloud when ready to expose agents.

    /// <summary>
    /// Returns the ID of the page that is used to configure the agent.
    /// </summary>
    /// <returns>The setup page ID.</returns>
    procedure GetSetupPageId(): Integer;

    /// <summary>
    /// Returns the page to be used to summarize an agent's activity.
    /// </summary>
    /// <returns>The summary page ID.</returns>
    procedure GetSummaryPageId(): Integer;

    /// <summary>
    /// Returns all agent task user intervention suggestions applicable to the specified agent task, page, and record.
    /// </summary>
    /// <param name="AgentUserId">The agent user id.</param>
    /// <param name="AgentTaskId">The agent task id.</param>
    /// <param name="PageId">The id of the page the suggestions are intended for.</param>
    /// <param name="RecordId">The record id for the page's underlying record.</param>
    /// <returns>The agent task user intervention suggestions.</returns>
    procedure GetAgentTaskUserInterventionSuggestions(AgentUserId: Guid; AgentTaskId: BigInteger; PageId: Integer; RecordId: RecordId; var AgentTaskUserInterventionSuggestion: Record "Agent Task User Int Suggestion");

    /// <summary>
    /// Returns the ID of the page that is used to display agent task messages for this agent.
    /// </summary>
    /// <remarks>The default generic Agent Task Message page is Page::"Agent Task Message Card".</remarks>
    procedure GetAgentTaskMessagePageId(): Integer;
}