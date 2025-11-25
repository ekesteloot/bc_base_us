// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents.Internal;

/// <summary>
/// Defines experimental capabilities related to agents.
/// These features are subject to change and should either be 
/// promoted to stable agent interfaces or removed entirely.
/// </summary>
interface IAgentExperimental
{
    Scope = OnPrem;

    /// <summary>
    /// Returns the page scripts proposed to agents during task execution.
    /// Provides experimental scripting capabilities for agent automation and page interaction.
    /// </summary>
    /// <param name="AgentUserId">The unique identifier for the agent user requesting page scripts</param>
    /// <param name="AgentTaskPageScript">Record containing the page scripts available to the agent for task execution</param>
    /// <remarks>
    /// This procedure is executed using the agent user.
    /// This method populates the AgentTaskPageScript record with scripts that enable agent automation.
    /// Scripts provide agents with page interaction capabilities during task processing.
    /// Experimental feature subject to change - may be promoted to stable interfaces or removed.
    /// </remarks>
    procedure GetPageScripts(AgentUserId: Guid; var AgentTaskPageScript: Record "Agent Task Page Script");
}