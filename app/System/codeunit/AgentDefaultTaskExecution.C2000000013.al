// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

/// <summary>
/// The default implementation for the Agent Task Execution.
/// </summary>
codeunit 2000000013 "Agent Default Task Execution" implements IAgentTaskExecution
{
    SingleInstance = true;
    Access = Internal;

    procedure AnalyzeAgentTaskMessage(AgentTaskMessage: Record "Agent Task Message"; var Annotations: Record "Agent Annotation")
    begin
    end;

    procedure GetAgentTaskUserInterventionSuggestions(AgentTaskUserInterventionRequestDetails: Record "Agent User Int Request Details"; var Suggestions: Record "Agent Task User Int Suggestion")
    begin
    end;

    procedure GetAgentTaskPageContext(AgentTaskPageContextRequest: Record "Agent Task Page Context Req."; var AgentTaskPageContext: Record "Agent Task Page Context")
    begin
    end;
}