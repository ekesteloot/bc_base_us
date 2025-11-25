// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

#pragma warning disable AS0018, AS0024, AS0066 // TODO(agent) remove once this has stabilized.
/// <summary>
/// Provides metadata for individual agents, including UI configuration, page context, and runtime annotations. 
/// Implementations define how agent-specific details are retrieved and displayed in the system.
/// </summary>
/// <remarks>
/// Implementations provide agent-specific UI configuration including initials, setup pages, and summary views.
/// Handles agent task user intervention suggestions and page context management.
/// Essential for agent runtime operations and user interface customization.
/// Integrates with agent task messaging and page context systems.
/// </remarks>
interface IAgentMetadata
{
    Scope = OnPrem; // TODO(agent) - This should change to Cloud when ready to expose agents;

    /// <summary>
    /// Returns the initials to be displayed on the icon opening the agent's timeline.
    /// </summary>
    /// <param name="AgentUserId">The agent user id.</param>
    /// <returns>The initials.</returns>
    procedure GetInitials(AgentUserId: Guid): Text[4];

    /// <summary>
    /// Returns the ID of the page that is used to configure the agent.
    /// </summary>
    /// <remarks>
    /// The source table of the page must contain a field named "User Security ID" of type Guid.
    /// This field is used by the runtime to provide the agent user ID when the page is opened.
    /// </remarks>
    /// <param name="AgentUserId">The agent user id.</param>
    /// <returns>The setup page ID.</returns>
    procedure GetSetupPageId(AgentUserId: Guid): Integer;

    /// <summary>
    /// Returns the page to be used to summarize an agent's activity.
    /// </summary>
    /// <remarks>
    /// The source table of the page must contain a field named "User Security ID" of type Guid.
    /// This field is used by the runtime to provide the agent user ID when the page is opened.
    /// </remarks>
    /// <param name="AgentUserId">The agent user id.</param>
    /// <returns>The summary page ID.</returns>
    procedure GetSummaryPageId(AgentUserId: Guid): Integer;

    /// <summary>
    /// Returns the ID of the page that is used to display agent task messages for this agent.
    /// </summary>
    /// <remarks>
    /// The source table of the page must be the <see cref="Agent Task Message"/> table.
    /// </remarks>
    /// <param name="AgentUserId">The agent user id.</param>
    /// <param name="MessageId">The ID of the message to display.</param>
    /// <returns>The ID of the page that is used to display agent task messages</returns>
    /// <remarks>The default generic Agent Task Message page is Page::"Agent Task Message Card".</remarks>
    procedure GetAgentTaskMessagePageId(AgentUserId: Guid; MessageId: Guid): Integer;

    /// <summary>
    /// Returns the list of annotations to be displayed for the agents.
    /// </summary>
    /// <remarks>
    /// These annotations are not persisted on the agent. The server regularly asks for the agent-level annotations.
    /// </remarks>
    /// <param name="AgentUserId">The agent user id.</param>
    /// <param name="Annotations">The annotations to be added to the agent.</param>
    procedure GetAgentAnnotations(AgentUserId: Guid; var Annotations: Record "Agent Annotation");
}
#pragma warning restore AS0024, AS0066 // TODO(agent) remove once this has stabilized.