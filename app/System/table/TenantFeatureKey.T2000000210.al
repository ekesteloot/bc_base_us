// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment.Configuration;

/// <summary>
/// Manages feature toggle keys for tenant-specific functionality, enabling controlled feature rollout and configuration.
/// </summary>
/// <remarks>
/// This table stores feature flags that control the availability of specific functionality within the tenant.
/// Each feature key can be enabled for all users or disabled, providing a mechanism for feature management
/// and controlled rollout of new capabilities. Used by the feature management framework to dynamically
/// enable or disable features without requiring application updates or deployments.
/// </remarks>
table 2000000210 "Tenant Feature Key"
{
    Caption = 'Tenant Feature Key';
    DataPerCompany = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Unique identifier for the feature key.
        /// </summary>
        field(1; ID; Text[50])
        {
            Caption = 'ID';
        }
        /// <summary>
        /// Enablement status of the feature for users within the tenant.
        /// </summary>
        field(2; Enabled; Option)
        {
            Caption = 'Enabled';
            OptionCaption = 'None,All Users';
            OptionMembers = "None","All Users";
        }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

