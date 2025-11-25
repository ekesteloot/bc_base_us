// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment.Configuration;

/// <summary>
/// Stores styling definitions and formatting templates for reports and pages enabling customized visual presentation.
/// Manages CSS-based styling configurations and design templates for consistent user interface appearance.
/// </summary>
/// <remarks>
/// This table manages visual styling and formatting definitions applied to Business Central objects. Stores CSS and styling templates that control the appearance of reports and pages. Used by the presentation layer for applying custom themes, layouts, and visual formatting to enhance user experience and corporate branding.
/// </remarks>
table 2000000066 "Style Sheet"
{
    Caption = 'Style Sheet';
    DataPerCompany = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Unique identifier for the style sheet configuration used for referencing and linking styling definitions.
        /// </summary>
        field(1; "Style Sheet ID"; Guid)
        {
            Caption = 'Style Sheet ID';
        }
        /// <summary>
        /// Type of Business Central object that the style sheet applies to for targeted styling.
        /// </summary>
        field(2; "Object Type"; Option)
        {
            Caption = 'Object Type';
            OptionMembers = ,"Report","Page";
            OptionCaption = ',Report,Page';
        }
        /// <summary>
        /// Unique identifier of the specific object that will use this style sheet.
        /// </summary>
        field(3; "Object ID"; Integer)
        {
            Caption = 'Object ID';
            TableRelation = System.Reflection.Object.ID WHERE(Type = FIELD("Object Type"));
        }
        /// <summary>
        /// Program or application identifier for context-specific styling associations.
        /// </summary>
        field(4; "Program ID"; Guid)
        {
            Caption = 'Program ID';
        }
        /// <summary>
        /// Descriptive name for the style sheet configuration for identification and management purposes.
        /// </summary>
        field(5; Name; Text[250])
        {
            Caption = 'Name';
        }
        /// <summary>
        /// Binary content containing the CSS styling definitions and formatting rules.
        /// </summary>
        field(6; "Style Sheet"; BLOB)
        {
            Caption = 'Style Sheet';
        }
        /// <summary>
        /// Creation or modification date of the style sheet for version tracking and management.
        /// </summary>
        field(7; Date; Date)
        {
            Caption = 'Date';
        }
    }

    keys
    {
        key(Key1; "Style Sheet ID")
        {
            Clustered = true;
        }
        key(Key2; "Object Type", "Object ID", "Program ID")
        {
        }
    }

    fieldgroups
    {
    }
}

