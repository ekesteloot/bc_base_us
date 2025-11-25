// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------

namespace System.Agents;

using System.Security.AccessControl;

codeunit 2000000022 "Agent Utilities"
{
    InherentEntitlements = X;
    InherentPermissions = X;

    /// <summary>
    /// Set the instructions for the specified agent.
    /// </summary>
    /// <param name="agentUserId">The agent user ID.</param>
    /// <param name="instructions">The instructions.</param>
    [Native]
    [Scope('OnPrem')]
    procedure SetInstructions(AgentUserID: Guid; Instructions: SecretText)
    begin
    end;

    /// <summary>
    /// Get the instructions for the specified agent.
    /// </summary>
    /// <param name="agentUserId">The agent user ID.</param>
    [Native]
    [Scope('OnPrem')]
    procedure GetInstructions(AgentUserID: Guid): SecretText
    begin
    end;

    /// <summary>
    /// Get whether the current session is an agent session.
    /// </summary>
    /// <param name="ActiveAgentMetadataProvider"></param>
    /// <returns>True if the current session is an agent session; otherwise, false.</returns>
    [Scope('OnPrem')]
    procedure IsAgentSession(var ActiveAgentMetadataProvider: Enum "Agent Metadata Provider"): Boolean
    var
        AgentType: Integer;
    begin
        if not GuiAllowed() then
            exit(false);

        AgentType := GetCurrentSessionAgentMetadataProviderType();
        if AgentType < 0 then
            exit(false);

        ActiveAgentMetadataProvider := "Agent Metadata Provider".FromInteger(AgentType);
        exit(true);
    end;

    /// <summary>
    /// Raise an error dialog if the current session is an agent session.
    /// </summary>
    [Scope('OnPrem')]
    procedure BlockPageFromBeingOpenedByAgent()
    var
        AgentMetadataProvider: Enum "Agent Metadata Provider";
        ThisPageCannotBeOpenedByAnAgentErr: Label 'This page cannot be opened by an agent.', Locked = true;
    begin
        if IsAgentSession(AgentMetadataProvider) then
            Error(ThisPageCannotBeOpenedByAnAgentErr);
    end;

    /// <summary>
    /// Get the agent task ID related to the current session, if any, -1 otherwise.
    /// </summary>
    /// <returns>The agent task ID, if any, -1 otherwise.</returns>
    [Native]
    [Scope('OnPrem')]
    procedure GetCurrentSessionAgentTaskId(): Integer
    begin
    end;

    /// <summary>
    /// Get the agent metadata provider type for the current session, if any, -1 otherwise.
    /// </summary>
    /// <returns>The agent metadata provider type, if any, -1 otherwise.</returns>
    [Native]
    [Scope('OnPrem')]
    procedure GetCurrentSessionAgentMetadataProviderType(): Integer
    begin
    end;

    /// <summary>
    /// Updates the access controls assigned to a custom agent.
    /// </summary>
    /// <param name="AgentUserSecurityId">The agent user security ID.</param>
    /// <param name="TempAccessControlBuffer">The temporary access control buffer.</param>
    [Native]
    [Scope('OnPrem')]
    procedure UpdateCustomAgentAccessControls(AgentUserSecurityId: Guid; var TempAccessControlBuffer: Record "Access Control Buffer" temporary)
    begin
    end;
}