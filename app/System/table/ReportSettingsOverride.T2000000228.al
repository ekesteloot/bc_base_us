// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment.Configuration;

using System.Environment;
using System.Globalization;
using System.Reflection;

/// <summary>
/// Stores report-specific configuration overrides for performance and behavior settings at the company level.
/// </summary>
/// <remarks>
/// This table manages company-specific overrides for report execution settings, including timeout limits, row limits, and formatting options.
/// Each record defines custom settings for a specific report and company combination, overriding default system settings.
/// Essential for performance tuning and controlling resource usage for reports in multi-company environments.
/// </remarks>
table 2000000228 "Report Settings Override"
{
    Caption = 'Report Settings Override';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// The identifier of the report object that these override settings apply to.
        /// </summary>
        field(1; "Object ID"; Integer)
        {
            Caption = 'Object ID';
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Report));
        }
        /// <summary>
        /// The name of the company that these report settings apply to.
        /// </summary>
        field(2; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            TableRelation = Company.Name;
        }
        /// <summary>
        /// The timeout limit in seconds for report execution, overriding the default system timeout.
        /// </summary>
        field(3; "Timeout"; Integer)
        {
            Caption = 'Timeout';
        }
        /// <summary>
        /// The maximum number of rows that the report can process, overriding the default system limit.
        /// </summary>
        field(4; "MaxRows"; Integer)
        {
            Caption = 'Maximum rows';
        }
        /// <summary>
        /// The maximum number of documents that the report can generate, overriding the default system limit.
        /// </summary>
        field(5; "MaxDocuments"; Integer)
        {
            Caption = 'Maximum documents';
        }
        /// <summary>
        /// The language tag for report formatting, overriding the default company or user language settings.
        /// </summary>
        field(6; "Format Language Tag"; Text[80]) // Length to match VT Windows Language field size
        {
            Caption = 'Format Language Tag';
            TableRelation = "Windows Language"."Language Tag";
        }
        /// <summary>
        /// The language ID for the application language, overriding the default language settings.
        /// </summary>
        field(7; "Language ID"; Integer)
        {
            Caption = 'Application Language';
            TableRelation = "Windows Language"."Language ID";
        }
    }

    keys
    {
        key(Key1; "Object ID", "Company Name")
        {
            Clustered = true;
        }
    }
}