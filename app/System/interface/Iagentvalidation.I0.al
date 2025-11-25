// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

interface IAgentValidation
{
    Scope = OnPrem; // TODO(agent) - This should change to Cloud when ready to expose agents.

    /// <summary>
    /// Returns the list of annotations to be displayed for the agents.
    /// </summary>
    /// <remarks>
    /// These annotations are not persisted on the agent. The server regularly asks for the agent-level annotations.
    /// </remarks>
    /// <param name="AgentUserId">The agent user id.</param>
    /// <param name="Annotations">The annotations to be added to the agent.</param>
    procedure GetAgentAnnotations(AgentUserId: Guid; var Annotations: Record "Agent Annotation");

    /// <summary>
    /// Returns the list of annotations to be displayed validation for the agent task message.
    /// Annotations whose severity is set to Error will stop the execution of the related task.
    /// Annotations whose severity is set to Warning will enforce a review of the message.
    /// </summary>
    /// <remarks>
    /// This is currently only called for incoming messages and not for outgoing messages.
    /// These annotations are persisted on the message. The server asks once for the message-level annotations.
    /// </remarks>
    /// <param name="AgentUserId">The agent user id.</param>
    /// <param name="TaskId">Specifies the id of the task the message belongs to.</param>
    /// <param name="TaskMessageId">Specifies the unique id for the message.</param>
    /// <param name="Annotations">The list of annotations for the message.</param>
    procedure GetTaskMessageAnnotations(AgentUserId: Guid; TaskId: BigInteger; TaskMessageId: Guid; var Annotations: Record "Agent Annotation");
}