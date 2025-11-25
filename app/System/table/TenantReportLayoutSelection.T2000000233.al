// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment.Configuration;

/// <summary>
/// Stores user and company-specific report layout selections at the tenant level, enabling personalized report formatting preferences.
/// This table manages which layout is selected for each report, allowing different layouts per user and company combination.
/// </summary>
/// <remarks>
/// This table maintains layout selection preferences for reports, supporting user-specific and company-specific customizations.
/// Each record defines the selected layout for a specific report, user, and company combination.
/// Data is not company-specific but tracks company association for proper layout scope management.
/// Extensibility points include custom layout selection logic and layout preference inheritance rules.
/// Related functionality: Report layout management, user preferences, and report rendering system.
/// </remarks>
table 2000000233 "Tenant Report Layout Selection"
{
    Caption = 'Tenant Report Layout Selection';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// Unique identifier of the report object for which the layout selection applies, establishing the report context.
        /// </summary>
        field(1; "Report ID"; Integer)
        {
            Caption = 'Report ID';
            TableRelation = System.Reflection.Object.ID WHERE("Type" = const(Report));
        }
        /// <summary>
        /// Name of the selected layout for the report, identifying which layout should be used for rendering.
        /// </summary>
        field(2; "Layout Name"; Text[250])
        {
            Caption = 'Layout Name';
        }
        /// <summary>
        /// Application identifier that owns the selected layout, used for app-specific layout management and validation.
        /// </summary>
        field(3; "App ID"; Guid)
        {
            Caption = 'App ID';
        }
        /// <summary>
        /// Name of the company for which this layout selection applies, enabling company-specific report formatting preferences.
        /// </summary>
        field(4; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            TableRelation = System.Environment.Company.Name;
        }
        /// <summary>
        /// Unique identifier of the user who made this layout selection, enabling user-specific report formatting preferences.
        /// </summary>
        field(5; "User ID"; Guid)
        {
            Caption = 'User ID';
        }
    }

    keys
    {
        key(key1; "Report ID", "Company Name", "User ID")
        {
            Clustered = true;
        }
    }
}
