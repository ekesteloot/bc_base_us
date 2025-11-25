// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Reflection;

/// <summary>
/// Virtual table that provides low-level system object information including metadata and source code access.
/// This table enables deep introspection of object definitions and is used for system administration and development tools.
/// </summary>
/// <remarks>
/// The System Object table provides system-level access to object definitions including
/// compiled metadata, source code, and object characteristics. This table is primarily used by
/// development tools, debuggers, and system administration utilities that require deep access to
/// object structures and implementation details. It includes binary metadata storage, AL source code access,
/// and hash verification for object integrity. This table is only available in on-premises deployments
/// where full system access is permitted and is essential for advanced development and diagnostic scenarios.
/// Access to this table requires elevated permissions due to its sensitive nature.
/// </remarks>
table 2000000029 "System Object"
{
    DataPerCompany = false;
    Scope = OnPrem;
    fields
    {
        /// <summary>
        /// The type of the object (Table, Page, Report, Codeunit, etc.).
        /// </summary>
        field(1; "Object Type"; option)
        {
            OptionCaption = 'TableData,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,System,FieldNumber,,,PageExtension,TableExtension,Enum,EnumExtension,Profile,ProfileExtension,PermissionSet,PermissionSetExtension,ReportExtension';
            OptionMembers = "TableData","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber",,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension","PermissionSet","PermissionSetExtension","ReportExtension";
        }
        /// <summary>
        /// The unique numeric identifier of the object within its type category.
        /// </summary>
        field(3; "Object ID"; Integer)
        {
        }
        /// <summary>
        /// The name of the object as defined in the AL source code.
        /// </summary>
        field(4; "Object Name"; Text[30])
        {
        }
        /// <summary>
        /// The caption text displayed for this object in the user interface.
        /// </summary>
        field(20; "Object Caption"; Text[80])
        {
        }
        /// <summary>
        /// The subtype classification of the object providing additional categorization information.
        /// </summary>
        field(21; "Object Subtype"; Text[30])
        {
            Caption = 'Object Subtype';
        }
        /// <summary>
        /// Binary storage containing the compiled metadata definition of the object.
        /// </summary>
        field(22; Metadata; BLOB)
        {
            Caption = 'Metadata';
        }
        /// <summary>
        /// Binary storage containing user-defined code or customizations for the object.
        /// </summary>
        field(23; "User Code"; BLOB)
        {
            Caption = 'User Code';
        }
        /// <summary>
        /// Binary storage containing the AL source code definition of the object.
        /// </summary>
        field(24; "User AL Code"; BLOB)
        {
            Caption = 'User AL Code';
        }
        /// <summary>
        /// Hash value used for verifying the integrity and versioning of the object metadata.
        /// </summary>
        field(25; "Metadata Hash"; Text[32])
        {
            Caption = 'Metadata Hash';
        }
        /// <summary>
        /// The AL namespace of the object.
        /// </summary>
        field(26; "AL Namespace"; text[500])
        {
        }
    }

    keys
    {
        key(pk; "Object Type", "Object ID")
        {
        }
    }
}