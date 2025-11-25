// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Migration;

/// <summary>
/// Stores field mapping definitions for data migration between source and target table structures.
/// </summary>
/// <remarks>
/// This table manages detailed field-level mappings used during data migration processes, particularly for cloud migrations.
/// Each record defines how a source table field maps to a target table field, including app context and transformation rules.
/// Essential for data migration scenarios where table structures differ between source and target environments.
/// </remarks>
table 2000000257 "Table Field Mappings"
{
    Caption = 'Table Field Mappings';
    DataPerCompany = false;
    Scope = Cloud;
    ReplicateData = false;

    fields
    {
        /// <summary>
        /// The unique identifier for this field mapping record.
        /// </summary>
        field(1; "ID"; Integer)
        {
            Caption = 'ID';
            AutoIncrement = true;
        }
        /// <summary>
        /// The name of the source table containing the field to be mapped.
        /// </summary>
        field(2; "From Table Name"; Text[150])
        {
            Caption = 'From Table Name';
        }
        /// <summary>
        /// The SQL name of the source table used in database operations.
        /// </summary>
        field(3; "From Table SQL Name"; Text[150])
        {
            Caption = 'From Table SQL Name';
        }
        /// <summary>
        /// The name of the source field that is being mapped.
        /// </summary>
        field(4; "From Table Field Name"; Text[150])
        {
            Caption = 'From Table Field Name';
        }
        /// <summary>
        /// The SQL name of the source field used in database operations.
        /// </summary>
        field(5; "From Field SQL Name"; Text[150])
        {
            Caption = 'From Field SQL Name';
        }
        /// <summary>
        /// The unique identifier of the app that contains the source table.
        /// </summary>
        field(6; "From APP ID"; Guid)
        {
            Caption = 'From APP ID';
        }
        /// <summary>
        /// The name of the app that contains the source table.
        /// </summary>
        field(7; "From App Name"; Text[150])
        {
            Caption = 'From App Name';
        }
        /// <summary>
        /// Indicates whether the source table is an extension table rather than a base table.
        /// </summary>
        field(8; "From Is Extension Table"; Boolean)
        {
            Caption = 'From Is Extension Table';
        }
        /// <summary>
        /// The name of the base table when the source is an extension table.
        /// </summary>
        field(9; "From Base Table Name"; Text[150])
        {
            Caption = 'From Base Table Name';
        }
        /// <summary>
        /// The SQL name of the base table when the source is an extension table.
        /// </summary>
        field(10; "From Base Table SQL Name"; Text[150])
        {
            Caption = 'From Base Table SQL Name';
        }
        /// <summary>
        /// The name of the target table where the field data will be migrated.
        /// </summary>
        field(11; "To Table Name"; Text[150])
        {
            Caption = 'To Table Name';
        }
        /// <summary>
        /// The SQL name of the target table used in database operations.
        /// </summary>
        field(12; "To Table SQL Name"; Text[150])
        {
            Caption = 'To Table SQL Name';
        }
        /// <summary>
        /// The name of the target table field that will receive the migrated data.
        /// </summary>
        field(13; "To Table Field Name"; Text[150])
        {
            Caption = 'To Table Field Name';
        }
        /// <summary>
        /// The SQL name of the target field used in database operations.
        /// </summary>
        field(14; "To Field SQL Name"; Text[150])
        {
            Caption = 'To Field SQL Name';
        }
        /// <summary>
        /// The unique identifier of the app that contains the target table.
        /// </summary>
        field(15; "To APP ID"; Guid)
        {
            Caption = 'To APP ID"';
        }
        /// <summary>
        /// The name of the app that contains the target table.
        /// </summary>
        field(16; "To App Name"; Text[150])
        {
            Caption = 'To App Name';
        }
        /// <summary>
        /// Indicates whether the target table is an extension table rather than a base table.
        /// </summary>
        field(17; "To Is Extension Table"; Boolean)
        {
            Caption = 'To Is Extension Table';
        }
        /// <summary>
        /// The name of the base table when the target is an extension table.
        /// </summary>
        field(18; "To Base Table Name"; Text[150])
        {
            Caption = 'To Base Table Name';
        }
        /// <summary>
        /// The SQL name of the base table when the target is an extension table.
        /// </summary>
        field(19; "To Base Table SQL Name"; Text[150])
        {
            Caption = 'To Base Table SQL Name';
        }
        /// <summary>
        /// The unique identifier of the app responsible for inserting data into the target table.
        /// </summary>
        field(20; "Inserter App ID"; Guid)
        {
            Caption = 'Inserter App ID';
        }
        /// <summary>
        /// The minimum BC major release version where this mapping applies.
        /// </summary>
        field(21; "Applies From BC Major Release"; Integer)
        {
            Caption = 'Applies From BC Major Release';
        }
        /// <summary>
        /// The minimum BC minor release version where this mapping applies.
        /// </summary>
        field(22; "Applies From BC Minor Release"; Integer)
        {
            Caption = 'Applies From BC Major Release';
        }
        /// <summary>
        /// Indicates whether the mapping is specific to a single company or applicable to all companies.
        /// </summary>
        field(23; "Per Company"; boolean)
        {
            Caption = 'Per Company';
        }
    }

    keys
    {
        key(Key1; "ID")
        {
            Clustered = true;
        }
        key(Key2; "To Table SQL Name", "To App Name", "To APP ID", "To Field SQL Name", "To Base Table SQL Name", "Applies From BC Major Release", "Applies From BC Minor Release")
        {
            Unique = true;
        }
    }

    fieldgroups
    {
    }
}

