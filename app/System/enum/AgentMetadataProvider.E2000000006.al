// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

enum 2000000006 "Agent Metadata Provider" implements IAgentFactory, IAgentMetadata, IAgentValidation
{
    Extensible = true;
    Caption = 'Agent Metadata Provider';
    Scope = OnPrem; // TODO(agent) - This should change to Cloud when ready to expose agents.
    DefaultImplementation = IAgentValidation = "Agent Default Validation";
}