// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

/// <summary>
/// Defines types of user intervention requests that agents can make during task execution.
/// Enables structured human-agent collaboration through specific intervention scenarios.
/// </summary>
/// <remarks>
/// Used for requesting different types of human oversight and assistance during agent operations.
/// Supports various intervention scenarios from simple review to task resumption.
/// Essential for maintaining human control and ensuring quality in agent task execution.
/// </remarks>
enum 2000000011 "Agent User Int Request Type"
{
    Extensible = false;
    Caption = 'Agent User Intervention Request Type';
    Scope = OnPrem;

    /// <summary>
    /// The user is asked to review an input or output message.
    /// </summary>
    value(0; ReviewMessage)
    {
        Caption = 'Review Message';
    }

    /// <summary>
    /// The agent requires assistance from the user.
    /// </summary>
    value(1; Assistance)
    {
        Caption = 'Assistance';
    }

    /// <summary>
    /// The user is asked to review changes made to a record/a new record.
    /// </summary>
    value(2; ReviewRecord)
    {
        Caption = 'Review Record';
    }

    /// <summary>
    /// The user is asked for input before the task is resumed.
    /// </summary>
    value(3; ResumeTask)
    {
        Caption = 'Resume Task';
    }

    /// <summary>
    /// The user is asked whether they want to retry the last step.
    /// </summary>
    value(4; Retry)
    {
        Caption = 'Retry';
    }
}