// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Integration;

/// <summary>
/// Stores Power BI report and dashboard definitions as binary content for integration with Microsoft Power BI services.
/// </summary>
/// <remarks>
/// This table manages Power BI artifacts including report templates, dashboard configurations, and visualization components. Supports versioning for update management and includes compatibility flags for different Power BI environments. Used by Power BI integration features for report deployment and management.
/// </remarks>
table 2000000144 "Power BI Blob"
{
    Caption = 'Power BI Blob';
    DataPerCompany = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Unique identifier for the Power BI artifact used for referencing and linking operations.
        /// </summary>
        field(1; Id; Guid)
        {
            Caption = 'Id';
        }
        /// <summary>
        /// Binary content containing the Power BI report definition, dashboard configuration, or visualization template.
        /// </summary>
        field(2; "Blob File"; BLOB)
        {
            Caption = 'Blob File';
        }
        /// <summary>
        /// Descriptive name for the Power BI artifact used for identification and selection in user interfaces.
        /// </summary>
        field(3; Name; Text[200])
        {
            Caption = 'Name';
        }
        /// <summary>
        /// Version number of the Power BI artifact for tracking updates and compatibility management.
        /// </summary>
        field(4; Version; Integer)
        {
            Caption = 'Version';
        }
        /// <summary>
        /// Indicates whether the Power BI artifact is compatible with or enabled for Great Plains integration scenarios.
        /// </summary>
        field(5; "GP Enabled"; Boolean)
        {
            Caption = 'GP Enabled';
        }
    }

    keys
    {
        key(Key1; Id)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

