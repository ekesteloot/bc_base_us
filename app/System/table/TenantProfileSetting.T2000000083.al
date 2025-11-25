// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment.Configuration;

/// <summary>
/// Contains the profile settings for profiles from extensions and from the in-client profile configuration.
/// </summary>
table 2000000083 "Tenant Profile Setting"
{
    Caption = 'Tenant Profile Setting';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;
    InherentPermissions = rX;

    fields
    {
        /// <summary>
        /// Application identifier that owns the profile for which these settings apply, enabling app-specific profile configuration.
        /// </summary>
        field(1; "App ID"; Guid)
        {
            Caption = 'App ID';
        }
        /// <summary>
        /// Unique identifier of the profile within the application for which these settings are defined.
        /// </summary>
        field(2; "Profile ID"; Code[30])
        {
            Caption = 'Profile ID';
        }
        /// <summary>
        /// Indicates whether this profile serves as the default role center for users who don't have a specific profile assigned.
        /// </summary>
        field(3; "Default Role Center"; Boolean)
        {
            Caption = 'Default Role Center';
        }
        /// <summary>
        /// Controls whether users can personalize pages and objects when using this profile, enforcing standardized user experiences.
        /// </summary>
        field(4; "Disable Personalization"; Boolean)
        {
            Caption = 'Disable Personalization';
        }
    }

    keys
    {
        key(Key1; "App ID", "Profile ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

