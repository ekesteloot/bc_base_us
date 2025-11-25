// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment;

/// <summary>
/// Provides business events for global table operation triggers and database-level record management.
/// Enables extensions to respond to record operations across all tables in the system.
/// </summary>
/// <remarks>
/// Contains events for global table triggers and database operations including insert, modify, delete, and rename.
/// Essential for extensions requiring cross-table auditing, logging, or validation logic.
/// Supports both application-level and database-level trigger management with configurable trigger masks.
/// </remarks>
codeunit 2000000002 "Global Triggers"
{

    trigger OnRun()
    begin
    end;

    /// <summary>
    /// Business event for retrieving global table trigger mask configuration.
    /// Enables configuration of which triggers are active for specific tables.
    /// </summary>
    /// <param name="TableID">Identifier of the table for trigger mask configuration</param>
    /// <param name="TableTriggerMask">Bitmask indicating which triggers are enabled for the table</param>
    /// <remarks>
    /// Raised when system needs to determine active trigger configuration for a table.
    /// </remarks>
    [BusinessEvent(false)]
    procedure GetGlobalTableTriggerMask(TableID: Integer; var TableTriggerMask: Integer)
    begin
    end;

    /// <summary>
    /// Business event raised when a record is inserted in any table.
    /// Enables global insert operation monitoring and custom logic.
    /// </summary>
    /// <param name="RecRef">Record reference for the inserted record</param>
    /// <remarks>
    /// Raised after record insertion across all tables in the system.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnGlobalInsert(RecRef: RecordRef)
    begin
    end;

    /// <summary>
    /// Business event raised when a record is modified in any table.
    /// Enables global modify operation monitoring and custom logic.
    /// </summary>
    /// <param name="RecRef">Record reference for the modified record</param>
    /// <param name="xRecRef">Record reference for the previous version of the record</param>
    /// <remarks>
    /// Raised after record modification across all tables in the system.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnGlobalModify(RecRef: RecordRef; xRecRef: RecordRef)
    begin
    end;

    /// <summary>
    /// Business event raised when a record is deleted from any table.
    /// Enables global delete operation monitoring and custom logic.
    /// </summary>
    /// <param name="RecRef">Record reference for the deleted record</param>
    /// <remarks>
    /// Raised after record deletion across all tables in the system.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnGlobalDelete(RecRef: RecordRef)
    begin
    end;

    /// <summary>
    /// Business event raised when a record is renamed in any table.
    /// Enables global rename operation monitoring and custom logic.
    /// </summary>
    /// <param name="RecRef">Record reference for the renamed record</param>
    /// <param name="xRecRef">Record reference for the previous version of the record</param>
    /// <remarks>
    /// Raised after record rename operation across all tables in the system.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnGlobalRename(RecRef: RecordRef; xRecRef: RecordRef)
    begin
    end;

    /// <summary>
    /// Business event for configuring database-level trigger setup for specific tables.
    /// Enables configuration of database trigger activation per table.
    /// </summary>
    /// <param name="TableId">Identifier of the table for database trigger configuration</param>
    /// <param name="OnDatabaseInsert">Whether database insert trigger should be active</param>
    /// <param name="OnDatabaseModify">Whether database modify trigger should be active</param>
    /// <param name="OnDatabaseDelete">Whether database delete trigger should be active</param>
    /// <param name="OnDatabaseRename">Whether database rename trigger should be active</param>
    /// <remarks>
    /// Raised when system needs to determine database trigger configuration for a table.
    /// </remarks>
    [BusinessEvent(false)]
    procedure GetDatabaseTableTriggerSetup(TableId: Integer; var OnDatabaseInsert: Boolean; var OnDatabaseModify: Boolean; var OnDatabaseDelete: Boolean; var OnDatabaseRename: Boolean)
    begin
    end;

    /// <summary>
    /// Business event raised at database level when a record is inserted.
    /// Enables database-level insert operation monitoring and custom logic.
    /// </summary>
    /// <param name="RecRef">Record reference for the inserted record</param>
    /// <remarks>
    /// Raised at database level after record insertion operations.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnDatabaseInsert(RecRef: RecordRef)
    begin
    end;

    /// <summary>
    /// Business event raised at database level when a record is modified.
    /// Enables database-level modify operation monitoring and custom logic.
    /// </summary>
    /// <param name="RecRef">Record reference for the modified record</param>
    /// <remarks>
    /// Raised at database level after record modification operations.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnDatabaseModify(RecRef: RecordRef)
    begin
    end;

    /// <summary>
    /// Business event raised at database level when a record is deleted.
    /// Enables database-level delete operation monitoring and custom logic.
    /// </summary>
    /// <param name="RecRef">Record reference for the deleted record</param>
    /// <remarks>
    /// Raised at database level after record deletion operations.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnDatabaseDelete(RecRef: RecordRef)
    begin
    end;

    /// <summary>
    /// Business event raised at database level when a record is renamed.
    /// Enables database-level rename operation monitoring and custom logic.
    /// </summary>
    /// <param name="RecRef">Record reference for the renamed record</param>
    /// <param name="xRecRef">Record reference for the previous version of the record</param>
    /// <remarks>
    /// Raised at database level after record rename operations.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnDatabaseRename(RecRef: RecordRef; xRecRef: RecordRef)
    begin
    end;
}

