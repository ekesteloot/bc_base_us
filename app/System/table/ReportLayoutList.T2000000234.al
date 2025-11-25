// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Reflection;

/// <summary>
/// Virtual table that provides a list of available report layouts in the system.
/// </summary>
/// <remarks>
/// This table exposes information about all report layouts including built-in and custom layouts
/// across different formats (RDLC, Word, Excel, Custom). Used by the reporting framework to enumerate
/// available layout options for reports and by tools that need to manage or select report layouts.
/// The table provides metadata including layout format, publisher information, and installation status.
/// </remarks>
table 2000000234 "Report Layout List"
{
    Caption = 'Report Layout List';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// The ID of the report that this layout belongs to.
        /// </summary>
        field(1; "Report ID"; Integer)
        {
            Caption = 'Report ID';
            TableRelation = "Report Metadata".ID;
        }

        /// <summary>
        /// The unique name identifier of the report layout.
        /// </summary>
        field(2; "Name"; Text[250])
        {
            Caption = 'Name';
        }

        /// <summary>
        /// The display caption for the report layout.
        /// </summary>
        field(3; "Caption"; Text[250])
        {
            Caption = 'Caption';
        }

        /// <summary>
        /// The multilanguage caption information for the report layout.
        /// </summary>
        field(4; "CaptionML"; Text[250])
        {
            Caption = 'CaptionML';
        }

        /// <summary>
        /// The runtime package ID that contains this layout definition.
        /// </summary>
        field(5; "Runtime Package ID"; Guid)
        {
            Caption = 'Runtime Package ID';
            TableRelation = "Report Layout Definition"."Runtime Package ID";
        }

        /// <summary>
        /// The binary content of the report layout file.
        /// </summary>
        field(6; "Layout"; Media)
        {
            Caption = 'Layout';
        }

        /// <summary>
        /// The format type of the report layout (RDLC, Word, Excel, or Custom).
        /// </summary>
        field(7; "Layout Format"; Option)
        {
            Caption = 'Layout Format';
            OptionCaption = 'RDLC,Word,Excel,External';
            OptionMembers = RDLC,Word,Excel,Custom;
        }

        /// <summary>
        /// The custom type identifier for custom layout formats.
        /// </summary>
        field(8; "Custom Type"; Guid)
        {
            Caption = 'Custom Type';
        }

        /// <summary>
        /// The MIME type of the layout file for proper handling and rendering.
        /// </summary>
        field(9; "MIME Type"; Text[255])
        {
            Caption = 'MIME Type';
        }

        /// <summary>
        /// A descriptive text explaining the purpose or characteristics of the layout.
        /// </summary>
        field(10; Description; Text[250])
        {
            Caption = 'Description';
        }

        /// <summary>
        /// The application ID that owns or provides this layout.
        /// </summary>
        field(11; "Application ID"; Guid)
        {
            Caption = 'Application ID';
        }

        /// <summary>
        /// The name of the report that this layout is associated with.
        /// </summary>
        field(12; "Report Name"; Text[250])
        {
            Caption = 'Report Name';
        }

        /// <summary>
        /// The publisher or provider of the report layout.
        /// </summary>
        field(13; "Layout Publisher"; Text[250])
        {
            Caption = 'Layout Provider';
        }

        /// <summary>
        /// Indicates whether this layout was created by a user rather than being system-provided.
        /// </summary>
        field(14; "User Defined"; Boolean)
        {
            Caption = 'User Defined';
        }

        /// <summary>
        /// Indicates whether the associated report is currently installed in the system.
        /// </summary>
        field(15; ReportIsInstalled; Boolean)
        {
            Caption = 'Report Is Installed';
        }

        /// <summary>
        /// Indicates whether this layout is marked as obsolete and should not be used.
        /// </summary>
        field(16; IsObsolete; Boolean)
        {
            Caption = 'Is Obsolete';
        }
        /// <summary>
        /// Configuration setting for Excel layouts regarding multiple data sheets handling.
        /// </summary>
        field(17; ExcelLayoutMultipleDataSheets; enum "Excel Sheet Configuration")
        {
            Caption = 'Excel Layout Multiple Data Sheets';
        }
    }

    keys
    {
        key(key1; "Report ID", "Name", "Runtime Package ID")
        {
            Clustered = true;
        }

        key(key2; "Report ID", "Name", "Application ID")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(Brick; "Report ID", Name, Caption, Description, "Layout Format")
        {
        }
    }
}
