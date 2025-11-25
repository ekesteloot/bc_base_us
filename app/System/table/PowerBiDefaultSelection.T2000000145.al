// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Integration;

/// <summary>
/// Manages default selection preferences for Power BI reports and dashboards within specific Business Central contexts.
/// </summary>
/// <remarks>
/// This table stores user and system preferences for Power BI content selection enabling automatic report and dashboard loading based on context. Supports context-aware Power BI integration with personalized default selections. Used by Power BI integration features for optimized user experience and content presentation.
/// </remarks>
table 2000000145 "Power BI Default Selection"
{
    Caption = 'Power BI Default Selection';
    DataPerCompany = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Unique identifier for the Power BI content item that can be selected as default.
        /// </summary>
        field(1; Id; Guid)
        {
            Caption = 'Id';
        }
        /// <summary>
        /// Context identifier defining where this default selection applies within Business Central.
        /// </summary>
        field(2; Context; Text[30])
        {
            Caption = 'Context';
        }
        /// <summary>
        /// Indicates whether this Power BI content is selected as the default for the specified context.
        /// </summary>
        field(3; Selected; Boolean)
        {
            Caption = 'Selected';
        }
    }

    keys
    {
        key(Key1; Id, Context)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

