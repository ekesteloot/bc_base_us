// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

enum 2000000005 "Agent Task Memory Entry Type"
{
    Extensible = false;
    Caption = 'Agent Task Memory Entry Type';
    Scope = OnPrem;

    /// <summary>
    /// An input or output message.
    /// </summary>
    value(0; "Message")
    {
        Caption = 'Message';
    }

    /// <summary>
    /// Any operation performed by the agent that involves interacting with the UI (setting field values, invoking actions, etc.).
    /// </summary>
    value(1; "Page Operation")
    {
        Caption = 'Page Operation';
    }

    /// <summary>
    /// A user intervention.
    /// </summary>
    value(2; "User Intervention")
    {
        Caption = 'User Intervention';
    }

    /// <summary>
    /// A summary of previous entries in the task.
    /// </summary>
    value(3; "Summary")
    {
        Caption = 'Summary';
    }

    /// <summary>
    /// The task was stopped.
    /// </summary>
    value(4; "Stop")
    {
        Caption = 'Stop';
    }

    /// <summary>
    /// A memory entry containing information the agent explicitly wants to remember.
    /// </summary>
    value(5; "Memorized Data")
    {
        Caption = 'Memorized Data';
    }
}