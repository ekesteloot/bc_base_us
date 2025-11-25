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
}