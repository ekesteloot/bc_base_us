// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Reflection;

/// <summary>
/// Virtual table that provides information about available field types in the AL language.
/// </summary>
/// <remarks>
/// This table exposes metadata about the different field types that can be used when defining tables,
/// including their display names, descriptions, icons, and categorization. Useful for development tools,
/// designers, and runtime reflection scenarios where field type information is needed.
/// The table is scoped to OnPrem and provides a catalog of supported field types.
/// </remarks>
table 2000000172 "Table Field Types"
{
    DataPerCompany = false;
    Scope = OnPrem;
    fields
    {
        /// <summary>
        /// The unique identifier for the field type.
        /// </summary>
        field(1; "Type ID"; Integer)
        {
        }
        /// <summary>
        /// The user-friendly display name of the field type.
        /// </summary>
        field(2; "Display Name"; Text[30])
        {
        }
        /// <summary>
        /// A detailed description of the field type and its usage.
        /// </summary>
        field(3; Description; Text[250])
        {
        }
        /// <summary>
        /// An icon associated with the field type for visual representation in tools.
        /// </summary>
        field(4; Icon; Media)
        {
        }
        /// <summary>
        /// A blank field used for layout purposes in field groups.
        /// </summary>
        field(5; Blank; Text[64])
        {
        }
        /// <summary>
        /// The category group that this field type belongs to for organizational purposes.
        /// </summary>
        field(6; FieldTypeGroup; Option)
        {
            OptionMembers = Number,Text,Boolean,DateTime,RelatedData,Option;
        }
    }

    keys
    {
        key(pk; "Type ID")
        {
        }
    }

    fieldgroups
    {
        fieldgroup("Brick"; Blank, Icon, "Display Name", Description)
        {
        }
    }
}