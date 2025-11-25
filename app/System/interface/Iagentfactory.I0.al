// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

using System.AI;

interface IAgentFactory
{
    Scope = OnPrem; // TODO(agent) - This should change to Cloud when ready to expose agents.

    /// <summary>
    /// Returns the initials to be displayed on the icon triggering the agent setup.
    /// </summary>
    /// <returns>The initials.</returns>
    procedure GetInitials(): Text[4];

    /// <summary>
    /// Returns the ID of the page that is used to configure the agent the first time.
    /// </summary>
    /// <returns>The first time setup page ID.</returns>
    procedure GetFirstTimeSetupPageId(): Integer;

    /// <summary>
    /// Specifies whether the capability to create new agents should be shown in the UI.
    /// </summary>
    /// <returns>True if the agent creation capability should be shown in the UI, false otherwise.</returns>
    procedure ShowCanCreateAgent(): Boolean

    /// <summary>
    /// Returns the Copilot Capability value for the agent.
    /// The capability is used to determine whether agents of this type are allowed to run.
    /// </summary>
    /// <returns>The copilot capability value.</returns>
    procedure GetCopilotCapability(): Enum "Copilot Capability";
}