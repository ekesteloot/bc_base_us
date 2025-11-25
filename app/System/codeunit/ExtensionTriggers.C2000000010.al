// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment;

/// <summary>
/// Provides business events for extension lifecycle management and installation hooks.
/// Enables extensions to respond to app installation events at database and company levels.
/// </summary>
/// <remarks>
/// Contains events for extension installation scenarios with both database and company scope.
/// Essential for extensions requiring installation-specific initialization or setup logic.
/// Supports extension management operations during app deployment lifecycle.
/// </remarks>
codeunit 2000000010 "Extension Triggers"
{
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    /// <summary>
    /// Business event raised when an app is installed at the database level.
    /// Enables database-wide initialization logic during app installation.
    /// </summary>
    /// <remarks>
    /// Raised during app installation process for database-level setup operations.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnInstallAppPerDatabase()
    begin
    end;

    /// <summary>
    /// Business event raised when an app is installed at the company level.
    /// Enables company-specific initialization logic during app installation.
    /// </summary>
    /// <remarks>
    /// Raised during app installation process for company-level setup operations.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnInstallAppPerCompany()
    begin
    end;
}

