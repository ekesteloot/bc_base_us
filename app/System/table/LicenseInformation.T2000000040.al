// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Security.AccessControl;

/// <summary>
/// Virtual table that provides information about the current license configuration and permissions.
/// This table enables checking of license restrictions, available features, and compliance information.
/// </summary>
/// <remarks>
/// The License Information table provides essential licensing details that control feature availability
/// and system behavior based on the current Business Central license. This information is crucial
/// for license compliance checks, feature enablement decisions, and administrative reporting.
/// The table contains structured license data that applications can query to determine which
/// features are available under the current licensing agreement. This enables dynamic feature
/// control and ensures compliance with licensing restrictions across the application suite.
/// </remarks>
table 2000000040 "License Information"
{
    DataPerCompany = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// The line number for organizing license information entries in sequence.
        /// </summary>
        field(1; "Line No."; Integer)
        {
        }
        /// <summary>
        /// The license information text containing specific license details, restrictions, or feature permissions.
        /// </summary>
        field(2; Text; Text[250])
        {
        }
    }

    keys
    {
        key(pk; "Line No.")
        {

        }
    }
}