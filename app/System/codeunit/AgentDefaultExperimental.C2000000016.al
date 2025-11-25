// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents.Internal;

/// <summary>
/// Provides default implementation for experimental agent functionality within the agent framework.
/// Implements IAgentExperimental interface to support extensible experimental agent features.
/// </summary>
/// <remarks>
/// Default implementation returns no page scripts for agent automation.
/// Part of experimental agent framework subject to change or removal.
/// Supports extensibility through interface implementation pattern for custom experimental features.
/// </remarks>
codeunit 2000000016 "Agent Default Experimental" implements IAgentExperimental
{
    SingleInstance = true;
    Access = Internal;

    /// <summary>
    /// Returns page scripts for agent automation and page interaction capabilities.
    /// Default implementation returns no scripts.
    /// </summary>
    /// <param name="AgentUserId">Unique identifier for the agent user requesting scripts</param>
    /// <param name="AgentTaskPageScript">Record to populate with available page scripts</param>
    procedure GetPageScripts(AgentUserId: Guid; var AgentTaskPageScript: Record "Agent Task Page Script");
    begin
    end;
}