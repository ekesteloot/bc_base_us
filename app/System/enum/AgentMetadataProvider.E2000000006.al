// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

using System.Agents.Internal;

/// <summary>
/// Defines extensible provider types for agent metadata and behavioral interfaces.
/// Enables custom agent implementations by allowing providers to implement specific agent interfaces.
/// </summary>
/// <remarks>
/// Implements IAgentFactory, IAgentMetadata, IAgentValidation, and IAgentExperimental interfaces.
/// Supports extensibility for custom agent providers while maintaining type safety.
/// Default implementations provided for validation and experimental functionality.
/// </remarks>
enum 2000000006 "Agent Metadata Provider" implements IAgentFactory, IAgentMetadata, IAgentTaskExecution, IAgentExperimental
{
    Extensible = true;
    Caption = 'Agent Metadata Provider';
    Scope = OnPrem; // TODO(agent) - This should change to Cloud when ready to expose agents.
    DefaultImplementation =
        IAgentTaskExecution = "Agent Default Task Execution",
        IAgentExperimental = "Agent Default Experimental";
}