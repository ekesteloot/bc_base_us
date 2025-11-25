// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Reflection;

/// <summary>
/// The [Object Metadata] table contains the metadata information for system tables with a SQL schema.
/// </summary>
/// <remarks>
/// This table originally contained metadata for all objects, but this role is now taken by [Application Object Metadata].
/// Later on, it only contained the metadata for all system objects, before being now limited to Application database tables.
/// If the list of system objects needs to be accessed, the [System Object] table should be used instead.
/// </remarks>
table 2000000071 "Object Metadata"
{
    Caption = 'Object Metadata';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Type of Business Central object defining the category and metadata structure.
        /// </summary>
        field(3; "Object Type"; Option)
        {
            Caption = 'Object Type';
            OptionMembers = "TableData","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber",,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension","PermissionSet","PermissionSetExtension","ReportExtension";
            OptionCaption = 'TableData,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,System,FieldNumber,,,PageExtension,TableExtension,Enum,EnumExtension,Profile,ProfileExtension,PermissionSet,PermissionSetExtension,ReportExtension';
        }
        /// <summary>
        /// Unique numeric identifier for the object within its type category.
        /// </summary>
        field(6; "Object ID"; Integer)
        {
            Caption = 'Object ID';
            TableRelation = Object.ID WHERE(Type = FIELD("Object Type"));
            //This property is currently not supported
            //TestTableRelation = false;
        }
        /// <summary>
        /// Binary storage containing compiled object metadata and structure information.
        /// </summary>
        field(9; Metadata; BLOB)
        {
            Caption = 'Metadata';
        }
        /// <summary>
        /// Binary storage for custom user code and modifications applied to the object.
        /// </summary>
        field(15; "User Code"; BLOB)
        {
            Caption = 'User Code';
        }
        /// <summary>
        /// Binary storage containing AL source code written by users for custom functionality.
        /// </summary>
        field(18; "User AL Code"; BLOB)
        {
            Caption = 'User AL Code';
        }
        /// <summary>
        /// Version number of the metadata format for compatibility and migration tracking.
        /// </summary>
        field(27; "Metadata Version"; Integer)
        {
            Caption = 'Metadata Version';
        }
        /// <summary>
        /// Hash value for metadata integrity verification and change detection.
        /// </summary>
        field(30; Hash; Text[32])
        {
            Caption = 'Hash';
        }
        /// <summary>
        /// Subtype classification providing additional categorization within the object type.
        /// </summary>
        field(33; "Object Subtype"; Text[30])
        {
            Caption = 'Object Subtype';
        }
        /// <summary>
        /// Indicates whether the object contains event subscribers for integration and extensibility.
        /// </summary>
        field(34; "Has Subscribers"; Boolean)
        {
            Caption = 'Has Subscribers';
        }
        /// <summary>
        /// Binary storage for symbol reference information used for compilation and linking.
        /// </summary>
        field(35; "Symbol Reference"; BLOB)
        {
            Caption = 'Symbol Reference';
        }
        /// <summary>
        /// Hash value for schema structure verification and compatibility checking.
        /// </summary>
        field(36; "Schema Hash"; Integer)
        {
            Caption = 'Schema Hash';
        }
        /// <summary>
        /// Emit version number tracking compilation output for deployment and versioning.
        /// </summary>
        field(37; "Emit Version"; Integer)
        {
            Caption = 'Emit Version';
        }
    }

    keys
    {
        key(Key1; "Object Type", "Object ID", "Emit Version")
        {
            Clustered = true;
        }
        key(Key2; "Emit Version")
        {
            Unique = false;
        }
    }

    fieldgroups
    {
    }
}

