// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

/// <summary>
/// Defines the current execution state of agent tasks throughout their lifecycle.
/// Provides status tracking from task creation through completion or termination.
/// </summary>
/// <remarks>
/// Used for task management, scheduling, and execution control within the agent framework.
/// Supports both natural task completion and forced termination scenarios.
/// Essential for task lifecycle management and execution monitoring.
/// </remarks>
enum 2000000004 "Agent Task Status"
{
    Extensible = false;
    Caption = 'Agent Task Status';

    /// <summary>
    /// The task is paused because because there is nothing to do (e.g. we have sent an outgoing message and are waiting for a response).
    /// This is also the initial status of a task until an input message is received.
    /// </summary>
    value(0; Paused)
    {
        Caption = 'Paused';
    }

    /// <summary>
    /// The task is ready to run (e.g. we have received new input for a stopped task).
    /// </summary>
    value(1; Ready)
    {
        Caption = 'Ready';
    }

    /// <summary>
    /// The task has been scheduled to run and will start running shortly.
    /// </summary>
    value(2; Scheduled)
    {
        Caption = 'Scheduled';
    }

    /// <summary>
    /// The task is currently running.
    /// </summary>
    value(3; Running)
    {
        Caption = 'Running';
    }

    /// <summary>
    /// The agent has determined the task has been completed. It can still be resumed if new input is received.
    /// </summary>
    value(4; "Completed")
    {
        Caption = 'Completed';
    }

    /// <summary>
    /// The task has been stopped by a user and will not continue running even if new input is received.
    /// </summary>
    value(5; "Stopped by User")
    {
        Caption = 'Stopped by User';
    }

    /// <summary>
    /// The task has been stopped by the system (e.g. harmful content has been detected in an input) and will not continue running even if new input is received.
    /// </summary>
    value(6; "Stopped by System")
    {
        Caption = 'Stopped by System';
    }
}