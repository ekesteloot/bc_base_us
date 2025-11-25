// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Reflection;

/// <summary>
/// Virtual table that provides access to metadata about all objects in the current database and installed applications.
/// This table enables introspection of the object structure including tables, pages, reports, codeunits, and other AL objects.
/// </summary>
/// <remarks>
/// The AllObj table is a fundamental metadata source used by various system features for object discovery,
/// navigation, and administrative purposes. It includes objects from the base application as well as installed extensions.
/// This table is commonly used for building object browsers, search functionality, and metadata analysis tools.
/// Access is restricted through inherent permissions to ensure security of metadata information.
/// </remarks>
table 2000000038 AllObj
{
    DataPerCompany = false;
    Scope = Cloud;
    InherentPermissions = rX;

    fields
    {
        /// <summary>
        /// Specifies the type of the object (Table, Page, Report, Codeunit, etc.).
        /// </summary>
        field(1; "Object Type"; Option)
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
        /// The AL namespace of the object.
        /// </summary>
        field(62; "AL Namespace"; text[500])
        {
        }
    }

    keys
    {
        key(pk; "Object Type", "Object ID")
        {

        }
    }

    FieldGroups
    {
        fieldgroup("DropDown"; "Object ID", "Object Type", "Object Name", "AL Namespace")
        {

        }
    }
}