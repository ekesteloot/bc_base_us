// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Upgrade;

/// <summary>
/// Provides business events for extending application upgrade functionality including precondition checks, upgrade operations, validation, and post-upgrade commit operations.
/// </summary>
/// <remarks>
/// This codeunit serves as an extensibility layer for the application upgrade process, enabling partners and developers to implement custom upgrade logic, perform validation checks, execute data migration tasks, and handle post-upgrade operations. All events are business events that follow the standard upgrade workflow phases and can be subscribed to by external extensions.
/// </remarks>
codeunit 2000000008 "Upgrade Triggers"
{
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

#pragma warning disable AL0299
    /// <summary>
    /// Business event that is triggered during the precondition check phase of upgrade at the database level.
    /// </summary>
    /// <remarks>
    /// Use this event to implement custom precondition validations that must pass before upgrade can proceed. Perform database-level checks such as data integrity validation, required configurations, or compatibility assessments that apply across all companies in the database.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnCheckPreconditionsPerDatabase()
    begin
    end;

    /// <summary>
    /// Business event that is triggered during the precondition check phase of upgrade at the company level.
    /// </summary>
    /// <remarks>
    /// Use this event to implement custom precondition validations that must pass before upgrade can proceed for a specific company. Perform company-specific checks such as data validation, configuration requirements, or business rule compliance that must be satisfied before upgrade operations begin.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnCheckPreconditionsPerCompany()
    begin
    end;

    /// <summary>
    /// Business event that is triggered during the main upgrade phase at the database level.
    /// </summary>
    /// <remarks>
    /// Use this event to implement custom upgrade logic that applies at the database level, such as system table modifications, global configuration updates, or cross-company data transformations. This event runs once per database during the upgrade process.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnUpgradePerDatabase()
    begin
    end;

    /// <summary>
    /// Business event that is triggered during the main upgrade phase at the company level.
    /// </summary>
    /// <remarks>
    /// Use this event to implement custom upgrade logic that applies to individual companies, such as company-specific data migrations, configuration updates, or business rule implementations. This event runs once per company during the upgrade process.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnUpgradePerCompany()
    begin
    end;

    /// <summary>
    /// Business event that is triggered during the validation phase of upgrade at the database level.
    /// </summary>
    /// <remarks>
    /// Use this event to implement custom validation logic that verifies upgrade success at the database level. Perform checks to ensure that database-level upgrade operations completed successfully and that the system is in a consistent state.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnValidateUpgradePerDatabase()
    begin
    end;

    /// <summary>
    /// Business event that is triggered during the validation phase of upgrade at the company level.
    /// </summary>
    /// <remarks>
    /// Use this event to implement custom validation logic that verifies upgrade success for individual companies. Perform company-specific checks to ensure that all upgrade operations completed successfully and that company data is in a consistent, usable state.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnValidateUpgradePerCompany()
    begin
    end;

    /// <summary>
    /// Business event that is triggered after upgrade operations are committed at the database level.
    /// </summary>
    /// <remarks>
    /// Use this event to implement post-upgrade operations that should execute after all database-level upgrade changes have been successfully committed. Perform cleanup operations, trigger external integrations, or execute final configuration steps that depend on completed upgrade operations.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnAfterUpgradeCommitPerDatabase()
    begin
    end;

    /// <summary>
    /// Business event that is triggered after upgrade operations are committed at the company level.
    /// </summary>
    /// <remarks>
    /// Use this event to implement post-upgrade operations that should execute after all company-level upgrade changes have been successfully committed. Perform company-specific cleanup, trigger business process workflows, or execute final configuration steps that depend on completed company upgrade operations.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnAfterUpgradeCommitPerCompany()
    begin
    end;
#pragma warning restore AL0299
}

