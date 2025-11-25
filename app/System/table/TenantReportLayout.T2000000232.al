// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment.Configuration;
using System.Reflection;

/// <summary>
/// Stores custom report layout definitions and templates for report rendering and formatting.
/// Manages tenant-specific report layouts in multiple formats including RDLC, Word, and Excel.
/// </summary>
/// <remarks>
/// This table enables customization of report appearance and structure through layout templates.
/// Integrates with the reporting framework, layout selection mechanisms, and report rendering services.
/// Supports multi-company scenarios and extension-based layout management for flexible report design.
/// </remarks>
table 2000000232 "Tenant Report Layout"
{
    Caption = 'Tenant Report Layout';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// Identifier of the report object that this layout applies to.
        /// </summary>
        field(1; "Report ID"; Integer)
        {
            Caption = 'Report ID';
            TableRelation = System.Reflection.Object.ID WHERE("Type" = const(Report));
        }

        /// <summary>
        /// Unique name identifier for the report layout within the tenant.
        /// </summary>
        field(2; "Name"; Text[250])
        {
            Caption = 'Name';
        }

        /// <summary>
        /// Legacy caption field for the report layout (obsolete).
        /// </summary>
        field(3; "Caption"; Text[250])
        {
            ObsoleteState = Pending;
            ObsoleteReason = 'This field should not be used. Use the Name field instead.';
            Caption = 'Caption';
        }

        /// <summary>
        /// Legacy multilingual caption field for the report layout (obsolete).
        /// </summary>
        field(4; "CaptionML"; Text[250])
        {
            ObsoleteState = Pending;
            ObsoleteReason = 'This field should not be used. Use the Name field instead.';
            Caption = 'CaptionML';
        }

        /// <summary>
        /// Unique identifier of the extension application that provides this layout.
        /// </summary>
        field(5; "App ID"; Guid)
        {
            Caption = 'App ID';
        }

        /// <summary>
        /// Company name scope for company-specific layout assignments.
        /// </summary>
        field(6; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            TableRelation = System.Environment.Company.Name;
        }

        /// <summary>
        /// Binary storage containing the actual report layout template data.
        /// </summary>
        field(7; "Layout"; Media)
        {
            Caption = 'Layout';
        }

        /// <summary>
        /// Format type of the report layout (RDLC, Word, Excel, or Custom).
        /// </summary>
        field(8; "Layout Format"; Option)
        {
            Caption = 'Layout Format';
            OptionCaption = 'RDLC,Word,Excel,External';
            OptionMembers = RDLC,Word,Excel,Custom;
        }

        /// <summary>
        /// Type identifier for custom layout formats requiring specialized rendering.
        /// </summary>
        field(9; "Custom Type"; Guid)
        {
            Caption = 'Custom Type';
        }

        /// <summary>
        /// MIME type specification for the layout file format and content type.
        /// </summary>
        field(10; "MIME Type"; Text[255])
        {
            Caption = 'MIME Type';
        }

        /// <summary>
        /// Descriptive text explaining the purpose and characteristics of the layout.
        /// </summary>
        field(11; Description; Text[250])
        {
            Caption = 'Description';
        }
        /// <summary>
        /// Indicates whether this layout is marked as obsolete and should not be used.
        /// </summary>
        field(12; IsObsolete; Boolean)
        {
            Caption = 'Is Obsolete';
        }
        /// <summary>
        /// Configuration setting for Excel layouts controlling multiple data sheet behavior.
        /// </summary>
        field(13; ExcelLayoutMultipleDataSheets; enum "Excel Sheet Configuration")
        {
            Caption = 'Excel Layout Multiple Data Sheets';
        }
    }

    keys
    {
        key(key1; "Report ID", "Name", "App ID")
        {
            Clustered = true;
        }
    }
}
