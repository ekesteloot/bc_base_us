// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

/// <summary>
/// The default implementation for the Agent Validation.
/// </summary>
codeunit 2000000013 "Agent Default Validation" implements IAgentValidation
{
    SingleInstance = true;

    procedure GetAgentAnnotations(AgentUserId: Guid; var Annotations: Record "Agent Annotation")
    begin
    end;

    procedure GetTaskMessageAnnotations(AgentUserId: Guid; TaskId: BigInteger; TaskMessageId: Guid; var Annotations: Record "Agent Annotation")
    begin
    end;
}