// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment;

/// <summary>
/// Provides business events for environment lifecycle management and copy operations.
/// Enables extensions to respond to environment copying between production and sandbox environments.
/// </summary>
/// <remarks>
/// Contains events for environment copy scenarios with both database and company-level scope.
/// Essential for extensions requiring environment-specific initialization or cleanup logic.
/// Supports environment management operations for production and sandbox environments.
/// </remarks>
codeunit 2000000012 "Environment Triggers"
{
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    /// <summary>
    /// Business event raised after an environment has been copied to a sandbox environment.
    /// Enables custom logic following environment copy operations.
    /// </summary>
    /// <remarks>
    /// Raised at database level after environment copy to sandbox is completed.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnAfterCopyEnvironmentToSandbox()
    begin
    end;

    /// <summary>
    /// Business event raised after an environment has been copied to sandbox per company.
    /// Enables company-specific logic following environment copy operations.
    /// </summary>
    /// <remarks>
    /// Raised at company level after environment copy to sandbox is completed.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnAfterCopyEnvironmentToSandboxPerCompany()
    begin
    end;

    /// <summary>
    /// Business event raised after environment copy operation at database level.
    /// Enables custom logic following database-level environment copy operations.
    /// </summary>
    /// <param name="SourceEnvironmentType">Type of source environment (Production or Sandbox)</param>
    /// <param name="SourceEnvironmentName">Name of the source environment</param>
    /// <param name="DestinationEnvironmentType">Type of destination environment (Production or Sandbox)</param>
    /// <param name="DestinationEnvironmentName">Name of the destination environment</param>
    /// <remarks>
    /// Raised at database level after environment copy between any environment types.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnAfterCopyEnvironmentPerDatabase(SourceEnvironmentType: Option Production,Sandbox; SourceEnvironmentName: Text; DestinationEnvironmentType: Option Production,Sandbox; DestinationEnvironmentName: Text)
    begin
    end;

    /// <summary>
    /// Business event raised after environment copy operation at company level.
    /// Enables company-specific logic following environment copy operations.
    /// </summary>
    /// <param name="SourceEnvironmentType">Type of source environment (Production or Sandbox)</param>
    /// <param name="SourceEnvironmentName">Name of the source environment</param>
    /// <param name="DestinationEnvironmentType">Type of destination environment (Production or Sandbox)</param>
    /// <param name="DestinationEnvironmentName">Name of the destination environment</param>
    /// <remarks>
    /// Raised at company level after environment copy between any environment types.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnAfterCopyEnvironmentPerCompany(SourceEnvironmentType: Option Production,Sandbox; SourceEnvironmentName: Text; DestinationEnvironmentType: Option Production,Sandbox; DestinationEnvironmentName: Text)
    begin
    end;
}

