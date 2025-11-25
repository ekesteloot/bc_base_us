// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment.Configuration;

/// <summary>
/// Stores configuration settings and permissions for Business Central apps at the tenant level.
/// </summary>
/// <remarks>
/// This table manages app-specific settings and capabilities within the tenant environment.
/// Each record defines permissions and behavior settings for individual apps, controlling features like HTTP client requests.
/// Essential for app security, capability management, and tenant-level app configuration in cloud environments.
/// </remarks>
table 2000000201 "NAV App Setting"
{
    Caption = 'NAV App Setting';
    DataPerCompany = false;
    Scope = Cloud;
    ReplicateData = false;

    fields
    {
        /// <summary>
        /// The unique identifier of the app that these settings apply to.
        /// </summary>
        field(1; "App ID"; Guid)
        {
            Caption = 'App ID';
        }
        /// <summary>
        /// Indicates whether the app is allowed to make HTTP client requests to external services.
        /// </summary>
        field(2; "Allow HttpClient Requests"; Boolean)
        {
            Caption = 'Allow HttpClient Requests';
        }
    }

    keys
    {
        key(Key1; "App ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

