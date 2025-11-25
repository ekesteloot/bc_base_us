// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Reflection;

/// <summary>
/// Legacy object metadata storage system superseded by Application Object Metadata table.
/// Maintains historical object registry for backwards compatibility during migration scenarios.
/// </summary>
/// <remarks>
/// This table is obsolete and replaced by Application Object Metadata (table 2000000207). Used historically for storing object definitions and metadata. Applications should transition to the newer Application Object Metadata structure for object management and reflection operations.
/// </remarks>
table 2000000001 Object
{
    Scope = OnPrem;
    ObsoleteState = Pending;
    ObsoleteReason = 'Object metadata is stored in Application Object Metadata.';

    fields
    {
        /// <summary>
        /// Type of Business Central object defining the category and behavior.
        /// </summary>
        field(1; Type; Option)
        {
            OptionMembers = TableData,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,System,FieldNumber;
        }
        /// <summary>
        /// Company context for the object enabling company-specific object isolation.
        /// </summary>
        field(2; "Company Name"; Text[30])
        {
            TableRelation = System.Environment.Company.Name;
        }
        /// <summary>
        /// Unique numeric identifier for the object within its type category.
        /// </summary>
        field(3; ID; Integer)
        {
        }
        /// <summary>
        /// Display name of the object for identification and user interface purposes.
        /// </summary>
        field(4; Name; Text[30])
        {
        }
        /// <summary>
        /// Indicates whether the object has been modified from its original state.
        /// </summary>
        field(5; Modified; Boolean)
        {
        }
        /// <summary>
        /// Indicates whether the object has been successfully compiled and is ready for execution.
        /// </summary>
        field(6; Compiled; Boolean)
        {
        }
        /// <summary>
        /// Binary storage for object metadata and source code content.
        /// </summary>
        field(7; "BLOB Reference"; Blob)
        {
        }
        /// <summary>
        /// Size in bytes of the binary content stored in the BLOB reference field.
        /// </summary>
        field(8; "BLOB Size"; Integer)
        {
        }
        /// <summary>
        /// Database manager table number for internal system object tracking.
        /// </summary>
        field(9; "DBM Table No."; Integer)
        {
        }
        /// <summary>
        /// Creation or modification date of the object for tracking and version management.
        /// </summary>
        field(10; Date; Date)
        {
        }
        /// <summary>
        /// Creation or modification time of the object for precise timestamp tracking.
        /// </summary>
        field(11; Time; Time)
        {
        }
        /// <summary>
        /// Version list tracking object modifications and customizations for version control.
        /// </summary>
        field(12; "Version List"; Text[248])
        {
        }
        /// <summary>
        /// User-friendly caption or description of the object for display purposes.
        /// </summary>
        field(20; "Caption"; Text[250])
        {
        }
        /// <summary>
        /// Indicates whether the object is locked for modification to prevent concurrent editing.
        /// </summary>
        field(40; "Locked"; Boolean)
        {
        }
        /// <summary>
        /// User identifier who has locked the object for exclusive modification access.
        /// </summary>
        field(50; "Locked By"; Text[132])
        {
        }
    }

    keys
    {
        key(pk; Type, "Company Name", ID)
        {
        }
        key(fk1; Type, Name)
        {
        }
        key(fk2; "Locked", "Locked By")
        {
        }
    }
}
