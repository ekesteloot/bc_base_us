// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------

namespace System.Agents;

/// <summary>
/// Provides core functionality for managing agent tasks within Business Central.
/// This codeunit handles task operations such as stopping tasks, encoding management, and task status updates.
/// </summary>
#pragma warning disable AS0090 // Renamed from 'Agent Task' to avoid name conflicts
codeunit 2000000018 "Agent Task Internal"
#pragma warning restore AS0090
{
    Access = Internal;
    InherentEntitlements = X;
    InherentPermissions = X;

    /// <summary>
    /// Gets the default text encoding used for agent task operations.
    /// </summary>
    /// <returns>The default text encoding (UTF8) used throughout the agent task system.</returns>
    procedure GetDefaultEncoding(): TextEncoding
    begin
        exit(TextEncoding::UTF8);
    end;

    /// <summary>
    /// Stops an agent task by updating its status and clearing attention flags.
    /// </summary>
    /// <param name="AgentTask">The agent task record to be stopped. Passed by reference and will be modified.</param>
    /// <param name="AgentTaskStatus">The target status to set for the agent task when stopping it.</param>
    /// <param name="UserConfirm">Specifies whether to show a confirmation dialog to the user before stopping the task.</param>
    [Scope('OnPrem')]
    procedure StopTask(var AgentTask: Record "Agent Task"; AgentTaskStatus: enum "Agent Task Status"; UserConfirm: Boolean)
    begin
        if ((AgentTask.Status = AgentTaskStatus) and (AgentTask."Needs Attention" = false)) then
            exit; // Task is already stopped and does not need attention.

        if UserConfirm then
            if not Confirm(AreYouSureThatYouWantToStopTheTaskQst) then
                exit;

        AgentTask.Status := AgentTaskStatus;
        AgentTask."Needs Attention" := false;
        AgentTask.Modify(true);
    end;

    var
        AreYouSureThatYouWantToStopTheTaskQst: Label 'Are you sure that you want to stop the task?';
}