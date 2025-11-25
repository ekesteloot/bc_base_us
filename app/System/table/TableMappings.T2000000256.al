// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Migration;

/// <summary>
/// Defines table mappings for data migration and upgrade scenarios between different application versions.
/// This table enables structured migration of data from source tables to destination tables during system upgrades.
/// </summary>
/// <remarks>
/// This table stores mapping information including source and destination table details, app ownership, and version applicability.
/// Supports both standard tables and extension table scenarios for complex migration requirements.
/// Data is not company-specific to ensure consistent migration logic across all companies.
/// Extensibility points include custom mapping logic events and migration transformation procedures.
/// Related functionality: Data migration framework, application upgrade processes, and table transformation logic.
/// </remarks>
table 2000000256 "Table Mappings"
{
    Caption = 'Table Mappings';
    DataPerCompany = false;
    Scope = Cloud;
    ReplicateData = false;

    fields
    {
        /// <summary>
        /// Auto-incrementing unique identifier for each table mapping record, providing primary key functionality.
        /// </summary>
        field(1; "ID"; Integer)
        {
            Caption = 'ID';
            AutoIncrement = true;
        }
        /// <summary>
        /// Display name of the source table from which data will be migrated during the upgrade process.
        /// </summary>
        field(2; "From Table Name"; Text[150])
        {
            Caption = 'From Table Name';
        }
        /// <summary>
        /// SQL name of the source table, used for database-level operations and direct table access during migration.
        /// </summary>
        field(3; "From Table SQL Name"; Text[150])
        {
            Caption = 'From Table SQL Name';
        }
        /// <summary>
        /// Application identifier that owns the source table, used for app-specific migration logic and validation.
        /// </summary>
        field(4; "From APP ID"; Guid)
        {
            Caption = 'From APP ID';
        }
        /// <summary>
        /// Display name of the application that owns the source table, providing human-readable app identification.
        /// </summary>
        field(5; "From App Name"; Text[150])
        {
            Caption = 'From App Name';
        }
        /// <summary>
        /// Indicates whether the source table is an extension table, affecting migration logic and base table relationships.
        /// </summary>
        field(6; "From Is Extension Table"; Boolean)
        {
            Caption = 'From Is Extension Table';
        }
        /// <summary>
        /// Name of the base table for the source table when it is an extension, used for complex migration scenarios.
        /// </summary>
        field(7; "From Base Table Name"; Text[150])
        {
            Caption = 'From Base Table Name';
        }
        /// <summary>
        /// SQL name of the base table for the source table, used for database operations involving extension relationships.
        /// </summary>
        field(8; "From Base Table SQL Name"; Text[150])
        {
            Caption = 'From Base Table SQL Name';
        }
        /// <summary>
        /// Display name of the destination table to which data will be migrated during the upgrade process.
        /// </summary>
        field(9; "To Table Name"; Text[150])
        {
            Caption = 'To Table Name';
        }
        /// <summary>
        /// SQL name of the destination table, used for database-level operations and direct table access during migration.
        /// </summary>
        field(10; "To Table SQL Name"; Text[150])
        {
            Caption = 'To Table SQL Name';
        }
        /// <summary>
        /// Application identifier that owns the destination table, used for app-specific migration logic and validation.
        /// </summary>
        field(11; "To APP ID"; Guid)
        {
            Caption = 'To APP ID"';
        }
        /// <summary>
        /// Display name of the application that owns the destination table, providing human-readable app identification.
        /// </summary>
        field(12; "To App Name"; Text[150])
        {
            Caption = 'To App Name';
        }
        /// <summary>
        /// Indicates whether the destination table is an extension table, affecting migration logic and base table relationships.
        /// </summary>
        field(13; "To Is Extension Table"; Boolean)
        {
            Caption = 'To Is Extension Table';
        }
        /// <summary>
        /// Name of the base table for the destination table when it is an extension, used for complex migration scenarios.
        /// </summary>
        field(14; "To Base Table Name"; Text[150])
        {
            Caption = 'To Base Table Name';
        }
        /// <summary>
        /// SQL name of the base table for the destination table, used for database operations involving extension relationships.
        /// </summary>
        field(15; "To Base Table SQL Name"; Text[150])
        {
            Caption = 'To Base Table SQL Name';
        }
        /// <summary>
        /// Application identifier of the app that created this mapping record, used for tracking mapping ownership and responsibility.
        /// </summary>
        field(16; "Inserter App ID"; Guid)
        {
            Caption = 'Inserter App ID';
        }
        /// <summary>
        /// Major version number of Business Central from which this mapping applies, defining version-specific migration rules.
        /// </summary>
        field(17; "Applies From BC Major Release"; Integer)
        {
            Caption = 'Applies From BC Major Release';
        }
        /// <summary>
        /// Minor version number of Business Central from which this mapping applies, providing fine-grained version control for migrations.
        /// </summary>
        field(18; "Applies From BC Minor Release"; Integer)
        {
            Caption = 'Applies From BC Major Release';
        }
        /// <summary>
        /// Indicates whether this mapping applies to per-company data, affecting the scope and execution of the migration process.
        /// </summary>
        field(19; "Per Company"; boolean)
        {
            Caption = 'Per Company';
        }
        /// <summary>
        /// Numeric identifier of the source table, providing direct table ID reference for migration operations.
        /// </summary>
        field(20; "From Table ID"; Integer)
        {
            Caption = 'From Table ID';
        }
        /// <summary>
        /// Numeric identifier of the destination table, providing direct table ID reference for migration operations.
        /// </summary>
        field(21; "To Table ID"; Integer)
        {
            Caption = 'To Table ID';
        }
    }

    keys
    {
        key(Key1; "ID")
        {
            Clustered = true;
        }
        key(Key2; "To Table SQL Name", "To App Name", "To APP ID", "To Base Table SQL Name", "Applies From BC Major Release", "Applies From BC Minor Release")
        {
            Unique = true;
        }
    }

    fieldgroups
    {
    }
}

