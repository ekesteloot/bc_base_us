// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

/// <summary>
/// Defines the contract for executing agent tasks which includes includes additional validation,
/// user intervention suggestions, and contextual data retrieval.
/// </summary>
/// <remarks>
/// These procedures are executed in the context of the agent user and help fine-tuning
/// how agents interact with the system during task execution.
/// </remarks>
#pragma warning disable AS0018 // TODO(agent) remove once this has stabilized.
interface IAgentTaskExecution
{
    Scope = OnPrem; // TODO(agent) - This should change to Cloud when ready to expose agents.

    /// <summary>
    /// Analyzes the content of an agent task message and its attachments.
    /// Returns the list of annotations to be displayed for the message.
    /// Annotations whose severity is set to Error will stop the execution of the related task.
    /// Annotations whose severity is set to Warning will enforce a review of the message.
    /// </summary>
    /// <remarks>
    /// This is currently only called for incoming messages and not for outgoing messages.
    /// These annotations are persisted on the message. The server asks once for the message-level annotations.
    /// </remarks>
    /// <param name="AgentTaskMessage">The agent task message.</param>
    /// <param name="Annotations">The list of annotations for the message.</param>
    procedure AnalyzeAgentTaskMessage(AgentTaskMessage: Record "Agent Task Message"; var Annotations: Record "Agent Annotation");

    /// <summary>
    /// Returns all agent task user intervention suggestions applicable to the specified agent task, page, and record.
    /// </summary>
    /// <param name="AgentTaskUserInterventionRequestDetails">The agent user intervention request details.</param>
    /// <param name="Suggestions">The agent task user intervention suggestions.</param>
    procedure GetAgentTaskUserInterventionSuggestions(AgentTaskUserInterventionRequestDetails: Record "Agent User Int Request Details"; var Suggestions: Record "Agent Task User Int Suggestion");

    /// <summary>
    /// Gets the current page context for the specified agent task, page, and record.
    /// This context is provided to the agent when interacting with the pages.
    /// </summary>
    /// <param name="AgentTaskPageContextRequest">The agent task page context request.</param>
    /// <returns>The agent task page context.</returns>
    procedure GetAgentTaskPageContext(AgentTaskPageContextRequest: Record "Agent Task Page Context Req."; var AgentTaskPageContext: Record "Agent Task Page Context");
}
#pragma warning restore AS0018