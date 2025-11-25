// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Tooling;

/// <summary>
/// Virtual table providing detailed information about page fields and their metadata for debugging and development purposes.
/// Used for page introspection, field analysis, and form development tooling.
/// </summary>
/// <remarks>
/// This table enables developers to examine page structures, field properties, and form state during runtime.
/// Useful for debugging page behavior, analyzing field configurations, and building development tools.
/// Provides both page-level information and detailed field metadata including values and filter expressions.
/// </remarks>
table 2000000204 "Page Info And Fields"
{
    Caption = 'Page Info And Fields';
    DataPerCompany = true;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Unique identifier for the current form instance, used to track specific form sessions.
        /// </summary>
        field(1; "Current Form ID"; Text[36])
        {
            Caption = 'Current Form ID';
        }
        /// <summary>
        /// Bookmark reference for the current form state, enabling navigation back to specific records.
        /// </summary>
        field(2; "Current Form Bookmark"; Text[2048])
        {
            Caption = 'Current Form Bookmark';
        }
        /// <summary>
        /// Numeric identifier of the field within the page structure.
        /// </summary>
        field(3; "Field No."; Integer)
        {
            Caption = 'Field No.';
        }
        /// <summary>
        /// Identifier of the page object containing this field.
        /// </summary>
        field(4; "Page ID"; Integer)
        {
            Caption = 'Page ID';
        }
        /// <summary>
        /// Display name of the page object.
        /// </summary>
        field(5; "Page Name"; Text[256])
        {
            Caption = 'Page Name';
        }
        /// <summary>
        /// Type classification of the page (List, Card, Document, etc.).
        /// </summary>
        field(6; "Page Type"; Text[1024])
        {
            Caption = 'Page Type';
        }
        /// <summary>
        /// Data type of the underlying source field or expression.
        /// </summary>
        field(7; "Source Data Type"; Text[1024])
        {
            Caption = 'Source Data Type';
        }
        /// <summary>
        /// Table number of the source table containing the field data.
        /// </summary>
        field(8; "Source Table No."; Integer)
        {
            Caption = 'Source Table No.';
        }
        /// <summary>
        /// Name of the source table containing the field data.
        /// </summary>
        field(9; "Source Table Name"; Text[256])
        {
            Caption = 'Source Table Name';
        }
        /// <summary>
        /// Name of the field as defined in the page or table structure.
        /// </summary>
        field(10; "Field Name"; Text[256])
        {
            Caption = 'Field Name';
        }
        /// <summary>
        /// Type classification of the field (Control, FlowField, etc.).
        /// </summary>
        field(11; "Field Type"; Text[1024])
        {
            Caption = 'Field Type';
        }
        /// <summary>
        /// Current value of the field formatted as text.
        /// </summary>
        field(12; "Field Value"; Text[2048])
        {
            Caption = 'Field Value';
        }
        /// <summary>
        /// Indicates whether this field is part of the primary key for the source table.
        /// </summary>
        field(13; IsPrimaryKey; Boolean)
        {
            Caption = 'IsPrimaryKey';
        }
        /// <summary>
        /// Information about the extension that provided this field, if applicable.
        /// </summary>
        field(14; ExtensionSource; Text[2048])
        {
            Caption = 'ExtensionSource';
        }
        /// <summary>
        /// Filter expression applied to this field, if any.
        /// </summary>
        field(15; "Field Filter Expression"; Text[2048])
        {
            Caption = 'Field Filter Expression';
        }
        /// <summary>
        /// Type of filter applied to this field (Range, Value, etc.).
        /// </summary>
        field(16; "Field Filter Type"; Text[1024])
        {
            Caption = 'Field Filter Type';
        }
        /// <summary>
        /// Additional metadata and properties of the field.
        /// </summary>
        field(17; "Field Info"; Text[1024])
        {
            Caption = 'Field Info';
        }
        /// <summary>
        /// Tooltip text displayed for this field in the user interface.
        /// </summary>
        field(18; Tooltip; Text[2048])
        {
            Caption = 'Tooltip';
        }
    }
    keys
    {
        key(Key1; "Current Form ID", "Current Form Bookmark", "Field No.")
        {
        }
    }
}