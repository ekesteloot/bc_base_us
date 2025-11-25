// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

using System.AI;
using System.Reflection;
using System.Security.AccessControl;

/// <summary>
/// Defines the contract for agent factories used to create and configure agents in the system.
/// Implementations of this interface provide metadata and configuration logic required during agent setup.
/// </summary>
/// <remarks>
/// Implementations must handle agent creation lifecycle, including initial setup pages and capability validation.
/// Integrates with Copilot Capability system for permission management and feature availability.
/// Used by the agent framework to instantiate and configure new agent instances.
/// </remarks>
interface IAgentFactory
{
    Scope = OnPrem; // TODO(agent) - This should change to Cloud when ready to expose agents.

    /// <summary>
    /// Returns the initials to be displayed on the icon triggering the agent setup.
    /// </summary>
    /// <returns>The initials.</returns>
    procedure GetDefaultInitials(): Text[4];

    /// <summary>
    /// Returns the ID of the page that is used to configure the agent the first time.
    /// </summary>
    /// <remarks>
    /// The source table of the page must contain a field named "User Security ID" of type Guid.
    /// This field is used by the runtime to provide the agent user ID when the page is opened.
    /// </remarks>
    /// <returns>The first time setup page ID.</returns>
    procedure GetFirstTimeSetupPageId(): Integer;

    /// <summary>
    /// Specifies whether the capability to create new agents should be shown in the UI.
    /// </summary>
    /// <remarks>
    /// This does not prevent new agents from being created programmatically.
    /// </remarks>
    /// <returns>True if the agent creation capability should be shown in the UI, false otherwise.</returns>
    procedure ShowCanCreateAgent(): Boolean

    /// <summary>
    /// Returns the Copilot Capability value for the agent.
    /// The capability is used to determine whether agents of this type are allowed to run.
    /// </summary>
    /// <returns>The copilot capability value.</returns>
    procedure GetCopilotCapability(): Enum "Copilot Capability";

    /// <summary>
    /// Get the agent default profile used when a new agent is created.
    /// </summary>
    /// <param name="TempAllProfile">The default profile.</param>
    /// <returns>The default profile.</returns>
    procedure GetDefaultProfile(var TempAllProfile: Record "All Profile" temporary);

    /// <summary>
    /// Get the agent default access controls to be used when a new agent is created.
    /// </summary>
    /// <param name="TempAccessControlBuffer">The default access controls.</param>
    /// <returns>The default permission sets.</returns>
    procedure GetDefaultAccessControls(var TempAccessControlBuffer: Record "Access Control Buffer" temporary);
}