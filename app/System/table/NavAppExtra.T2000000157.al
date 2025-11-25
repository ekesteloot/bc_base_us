// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Apps;

/// <summary>
/// Virtual table that provides additional metadata information about extensions.
/// </summary>
/// <remarks>
/// This table exposes extended properties and configuration details for installed applications,
/// including tenant visibility settings and installation status. Essential for application lifecycle
/// management, multi-tenant deployment scenarios, and extension administration. Used by the platform
/// to determine application visibility and availability across different tenant contexts.
/// The table is scoped to OnPrem for access to detailed application deployment information.
/// </remarks>
table 2000000157 "NAV App Extra"
{
    Caption = 'NAV App Extra';
    DataPerCompany = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// The runtime package identifier of the application.
        /// </summary>
        field(1; "Runtime Package ID"; GUID)
        {
            Caption = 'Runtime Package ID';
        }
        /// <summary>
        /// Indicates whether the application is visible to tenants in multi-tenant scenarios.
        /// </summary>
        field(2; "Tenant Visible"; Boolean)
        {
            Caption = 'Tenant Visible';
        }
        /// <summary>
        /// Indicates whether the application is installed per-tenant or globally installed.
        /// </summary>
        field(3; "PerTenant Or Installed"; Boolean)
        {
            Caption = 'PerTenant Or Installed';
        }
        /// <summary>
        /// The package identifier that uniquely identifies this application package.
        /// </summary>
        field(4; "Package ID"; GUID)
        {
            Caption = 'Package ID';
        }
    }
    keys
    {
        key(Key1; "Runtime Package ID")
        {
        }
    }
}