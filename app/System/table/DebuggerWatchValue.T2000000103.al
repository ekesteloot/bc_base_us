// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Tooling;

/// <summary>
/// Virtual table containing debugger watch expressions and their current values during debugging sessions.
/// Provides real-time variable and expression monitoring capabilities for AL code debugging.
/// </summary>
/// <remarks>
/// This table enables debuggers to track variable values, expressions, and scope information during
/// code execution. Used by development tools to provide watch windows, variable inspection, and
/// debugging assistance. Supports call stack context and scope-aware variable tracking.
/// </remarks>
table 2000000103 "Debugger Watch Value"
{
    DataPerCompany = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Identifier linking this watch value to a specific call stack entry.
        /// </summary>
        field(1; "Call Stack ID"; Integer)
        {
            //TableRelation=#2000000101.#1;
        }
        /// <summary>
        /// Unique identifier for the watch expression within the debugging session.
        /// </summary>
        field(3; "Watch ID"; Integer)
        {
        }
        /// <summary>
        /// Name of the variable or expression being watched.
        /// </summary>
        field(7; Name; Text[124])
        {
        }
        /// <summary>
        /// Current value of the watched variable or expression formatted as text.
        /// </summary>
        field(9; Value; Text[250])
        {
        }
        /// <summary>
        /// Data type of the watched variable or expression result.
        /// </summary>
        field(11; Type; Text[128])
        {
        }
        /// <summary>
        /// Indicates whether the watched variable is currently within execution scope.
        /// </summary>
        field(13; "In Scope"; Boolean)
        {
        }
    }

    keys
    {
        key(pk; "Call Stack ID", "Watch ID")
        {
        }
    }
}