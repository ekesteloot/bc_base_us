// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Reflection;

using System.Apps;

/// <summary>
/// Stores report layout definitions including RDLC, Word, Excel, and custom layouts for report rendering and output formatting.
/// </summary>
/// <remarks>
/// This table manages report layout metadata and binary content for various report formats. Supports application-specific layouts through runtime package linking and includes configuration for Excel multi-sheet layouts. Used by the reporting engine for layout selection and rendering operations.
/// </remarks>
table 2000000231 "Report Layout Definition"
{
    Caption = 'Report Layout Definition';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// Identifier of the report object that this layout definition applies to.
        /// </summary>
        field(1; "Report ID"; Integer)
        {
            Caption = 'Report ID';
            TableRelation = Object.ID WHERE("Type" = const(Report));
        }

        /// <summary>
        /// Unique name identifier for the layout definition within the report context.
        /// </summary>
        field(2; "Name"; Text[250])
        {
            Caption = 'Name';
        }

        /// <summary>
        /// Display caption for the layout definition. This field is obsolete and caption should be obtained from metareport.
        /// </summary>
        field(3; "Caption"; Text[250])
        {
            ObsoleteState = Pending;
            ObsoleteReason = 'This field should not be used. Instead, the layout caption should be obtained from the metareport';
            Caption = 'Caption';
        }

        /// <summary>
        /// Multi-language caption for the layout definition. This field is obsolete and caption should be obtained from metareport.
        /// </summary>
        field(4; "CaptionML"; Text[250])
        {
            ObsoleteState = Pending;
            ObsoleteReason = 'This field should not be used. Instead, the layout caption should be obtained from the metareport';
            Caption = 'CaptionML';
        }

        /// <summary>
        /// Runtime package identifier linking the layout to a specific application installation.
        /// </summary>
        field(5; "Runtime Package ID"; Guid)
        {
            Caption = 'Runtime Package ID';
            TableRelation = "Installed Application"."Runtime Package ID";
        }

        /// <summary>
        /// Binary layout content stored as media for rendering operations and layout processing.
        /// </summary>
        field(6; "Layout"; Media)
        {
            Caption = 'Layout';
        }

        /// <summary>
        /// Format type of the layout defining the rendering engine and processing method.
        /// </summary>
        field(7; "Layout Format"; Option)
        {
            Caption = 'Layout Format';
            OptionCaption = 'RDLC,Word,Excel,External';
            OptionMembers = RDLC,Word,Excel,Custom;
        }

        /// <summary>
        /// Custom type identifier for external layout renderers. This field is obsolete and only MIME type should be used.
        /// </summary>
        field(8; "Custom Type"; Guid)
        {
            ObsoleteState = Pending;
            ObsoleteReason = 'This field should not be used. Custom reports only specify the mimetype.';
            Caption = 'Custom Type';
        }

        /// <summary>
        /// MIME type specification for the layout content enabling proper processing and rendering.
        /// </summary>
        field(9; "MIME Type"; Text[255])
        {
            Caption = 'MIME Type';
        }

        /// <summary>
        /// Descriptive text for the layout definition. This field is obsolete and description should be obtained from metareport.
        /// </summary>
        field(10; Description; Text[250])
        {
            ObsoleteState = Pending;
            ObsoleteReason = 'This field should not be used. Instead, the layout description should be obtained from the metareport';
            Caption = 'Description';
        }
        /// <summary>
        /// Indicates whether the layout definition is marked as obsolete and should not be used for new reports.
        /// </summary>
        field(11; IsObsolete; Boolean)
        {
            Caption = 'Is bsolete';
        }
        /// <summary>
        /// Configuration setting for Excel layouts controlling whether data is distributed across multiple sheets.
        /// </summary>
        field(12; ExcelLayoutMultipleDataSheets; enum "Excel Sheet Configuration")
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
    }
}
