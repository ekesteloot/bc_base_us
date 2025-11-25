// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Tooling;

/// <summary>
/// Provides business events for debugger-related functionality and breakpoint management.
/// Contains legacy debugger events for backward compatibility with obsolete debugger engine.
/// </summary>
/// <remarks>
/// Contains obsolete events related to classic debugger engine support.
/// Maintained for backward compatibility but classic debugger functionality has been removed.
/// Modern debugging should use current VS Code debugging capabilities.
/// </remarks>
codeunit 2000000009 "Debugger Triggers"
{
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    /// <summary>
    /// Obsolete business event previously raised when debugger breakpoint was hit.
    /// Classic debugger engine support has been removed from the platform.
    /// </summary>
    /// <param name="ErrorMessage">Error message text from debugger break context</param>
    /// <remarks>
    /// Raised when classic debugger breakpoint was encountered during code execution.
    /// </remarks>
    [BusinessEvent(false)]
    [Obsolete('Support for the classic debugger engine has been removed.')]
    procedure OnDebuggerBreak(ErrorMessage: Text)
    begin
    end;
}

