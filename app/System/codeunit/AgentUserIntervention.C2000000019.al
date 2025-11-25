// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------

namespace System.Agents;

/// <summary>
/// Provides functionality for creating and managing user interventions in agent tasks.
/// This codeunit handles the creation of user intervention responses to agent requests,
/// including processing user input and suggestion selections.
/// </summary>
codeunit 2000000019 "Agent User Intervention"
{
    InherentEntitlements = X;
    InherentPermissions = X;

    /// <summary>
    /// Creates a user intervention response for an agent task log entry without additional input.
    /// </summary>
    /// <param name="UserInterventionRequestEntry">The agent task log entry that requested user intervention.</param>
    [Scope('OnPrem')]
    procedure CreateUserIntervention(UserInterventionRequestEntry: Record "Agent Task Log Entry")
    begin
        CreateUserIntervention(UserInterventionRequestEntry, '', -1);
    end;

    /// <summary>
    /// Creates a user intervention response with custom user input text.
    /// </summary>
    /// <param name="UserInterventionRequestEntry">The agent task log entry that requested user intervention.</param>
    /// <param name="UserInput">Additional text input provided by the user as part of the intervention response.</param>
    [Scope('OnPrem')]
    procedure CreateUserIntervention(UserInterventionRequestEntry: Record "Agent Task Log Entry"; UserInput: Text)
    begin
        CreateUserIntervention(UserInterventionRequestEntry, UserInput, -1);
    end;

    /// <summary>
    /// Creates a user intervention response with a selected suggestion ID.
    /// </summary>
    /// <param name="UserInterventionRequestEntry">The agent task log entry that requested user intervention.</param>
    /// <param name="SelectedSuggestionId">The ID of the suggestion selected by the user from the available options.</param>
    [Scope('OnPrem')]
    procedure CreateUserIntervention(UserInterventionRequestEntry: Record "Agent Task Log Entry"; SelectedSuggestionId: Integer)
    begin
        CreateUserIntervention(UserInterventionRequestEntry, '', SelectedSuggestionId);
    end;

    /// <summary>
    /// Creates a user intervention response with both user input and a suggestion ID provided as text.
    /// </summary>
    /// <param name="UserInterventionRequestEntry">The agent task log entry that requested user intervention.</param>
    /// <param name="UserInput">Additional text input provided by the user as part of the intervention response.</param>
    /// <param name="SelectedSuggestionId">The suggestion ID as text that will be converted to integer. If invalid, logs an error and proceeds without suggestion selection.</param>
    [Scope('OnPrem')]
    procedure CreateUserIntervention(UserInterventionRequestEntry: Record "Agent Task Log Entry"; UserInput: Text; SelectedSuggestionId: Text)
    var
        SelectedSuggestionIdInt: Integer;
    begin
        if SelectedSuggestionId <> '' then
            if Evaluate(SelectedSuggestionIdInt, SelectedSuggestionId) then begin
                CreateUserIntervention(UserInterventionRequestEntry, UserInput, SelectedSuggestionIdInt);
                exit;
            end
            else
                Session.LogMessage('0000PKA', StrSubstNo(InvalidSelectedSuggestionIdErr, SelectedSuggestionId), Verbosity::Error, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, 'Category', CategoryTok);

        CreateUserIntervention(UserInterventionRequestEntry, UserInput);
    end;

    /// <summary>
    /// Creates a user intervention response with both user input and a selected suggestion ID.
    /// </summary>
    /// <param name="UserInterventionRequestEntry">The agent task log entry that requested user intervention.</param>
    /// <param name="UserInput">Additional text input provided by the user as part of the intervention response.</param>
    /// <param name="SelectedSuggestionId">The integer ID of the suggestion selected by the user from the available options.</param>
    [Scope('OnPrem')]
    procedure CreateUserIntervention(UserInterventionRequestEntry: Record "Agent Task Log Entry"; UserInput: Text; SelectedSuggestionId: Integer)
    var
        AgentTask: Record "Agent Task";
    begin
        AgentTask.Get(UserInterventionRequestEntry."Task ID");
        CreateUserInterventionInternal(AgentTask."Agent User Security ID", AgentTask.ID, UserInterventionRequestEntry.ID, UserInput, SelectedSuggestionId);
    end;

    [Native]
    local procedure CreateUserInterventionInternal(AgentUserSecurityId: Guid; AgentTaskId: BigInteger; UserInterventionRequestEntryId: Integer; UserInput: Text; SelectedSuggestionId: Integer)
    begin
    end;

    var
        InvalidSelectedSuggestionIdErr: Label 'Invalid SelectedSuggestionId: %1', Comment = '%1 - SelectedSuggestionId', Locked = true;
        CategoryTok: Label 'Agents', Locked = true;
}