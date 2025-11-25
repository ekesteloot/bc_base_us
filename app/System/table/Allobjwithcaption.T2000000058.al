// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Reflection;

/// <summary>
/// Virtual table that provides object metadata including captions and subtypes for all objects in the system.
/// This table extends the basic AllObj table with additional display and categorization information.
/// </summary>
/// <remarks>
/// The AllObjWithCaption table enhances basic object metadata with user-facing information such as
/// object captions, subtypes, and application identifiers. This table is particularly useful for
/// building user interfaces that need to display objects with their localized captions and
/// categorize them by subtype. It provides a complete view of all objects in the system including
/// those from the base application and all installed extensions, making it ideal for object browsers,
/// search functionality, and administrative tools that require rich object metadata.
/// </remarks>
table 2000000058 AllObjWithCaption
{
    DataPerCompany = false;
    Scope = Cloud;
    InherentPermissions = rX;

    fields
    {
        /// <summary>
        /// The type of the object (Table, Page, Report, Codeunit, etc.).
        /// </summary>
        field(1; "Object Type"; option)
        {
            OptionMembers = "TableData","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber",,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension","PermissionSet","PermissionSetExtension","ReportExtension";
            OptionCaption = 'TableData,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,System,FieldNumber,,,PageExtension,TableExtension,Enum,EnumExtension,Profile,ProfileExtension,PermissionSet,PermissionSetExtension,ReportExtension';
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
        /// The caption text displayed for this object in the user interface, localized if applicable.
        /// </summary>
        field(20; "Object Caption"; Text[249])
        {
        }
        /// <summary>
        /// The subtype classification of the object providing additional categorization information.
        /// </summary>
        field(30; "Object Subtype"; Text[30])
        {
        }
        /// <summary>
        /// The package identifier of the application that contains this object.
        /// </summary>
        field(60; "App Package ID"; Guid)
        {
        }
        /// <summary>
        /// The runtime package identifier used by the platform for application management.
        /// </summary>
        field(61; "App Runtime Package ID"; Guid)
        {
        }
        /// <summary>
        /// The application identifier that owns this object.
        /// </summary>
        field(62; "App ID"; Guid)
        {
        }
        /// <summary>
        /// The AL namespace of the object.
        /// </summary>
        field(63; "AL Namespace"; text[500])
        {
        }
    }

    keys
    {
        key(pk; "Object Type", "Object ID")
        {

        }
    }
    fieldGroups
    {
        fieldgroup("DropDown"; "Object ID", "Object Type", "Object Caption", "AL Namespace")
        {

        }
    }
}