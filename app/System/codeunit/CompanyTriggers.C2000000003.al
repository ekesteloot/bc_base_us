// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment;

/// <summary>
/// Provides business events for company lifecycle management and operation hooks.
/// Enables extensions to respond to company opening, closing, and configuration events.
/// </summary>
/// <remarks>
/// Contains business events for company state changes and settings management.
/// Essential for extensions requiring company-level initialization and cleanup logic.
/// Supports both OnPrem and cloud environment scenarios with appropriate scoping.
/// </remarks>
codeunit 2000000003 "Company Triggers"
{
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    /// <summary>
    /// Business event raised when a company is opened in the system.
    /// Enables custom initialization logic during company access.
    /// </summary>
    /// <remarks>
    /// Raised during company opening process before user interface is fully loaded.
    /// </remarks>
    [Scope('OnPrem')]
    [BusinessEvent(false)]
    procedure OnCompanyOpen()
    begin
    end;

    /// <summary>
    /// Business event raised when company opening process has completed successfully.
    /// Enables post-initialization logic after company is fully accessible.
    /// </summary>
    /// <remarks>
    /// Raised after company opening process is complete.
    /// </remarks>
    [BusinessEvent(false, true)]
    procedure OnCompanyOpenCompleted()
    begin
    end;

    /// <summary>
    /// Business event raised when a company is being closed in the system.
    /// Enables custom cleanup logic during company closure.
    /// </summary>
    /// <remarks>
    /// Raised during company closing process for cleanup and finalization operations.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnCompanyClose()
    begin
    end;

    /// <summary>
    /// Business event raised when company settings functionality is invoked.
    /// Enables custom company configuration and settings management.
    /// </summary>
    /// <remarks>
    /// Raised when user requests company settings access or configuration.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OpenCompanySettings()
    begin
    end;
}

