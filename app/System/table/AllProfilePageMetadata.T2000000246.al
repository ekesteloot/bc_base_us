// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment.Configuration;

/// <summary>
/// Virtual table containing metadata about page customizations associated with user profiles.
/// Provides information linking profiles to their page-specific configurations and customizations.
/// </summary>
/// <remarks>
/// This table enables profile management systems to track which pages have been customized for specific profiles,
/// including cross-extension relationships between profile definitions and page customizations.
/// Used by the personalization framework and profile management tools to maintain consistency
/// across profile-based user experiences.
/// </remarks>
table 2000000246 "All Profile Page Metadata"
{
    Caption = 'All Profile Page Metadata';
    DataPerCompany = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// Unique identifier of the extension application that contains the page customization.
        /// </summary>
        field(1; "App ID"; Guid)
        {
            Caption = 'App ID';
        }
        /// <summary>
        /// Unique identifier of the extension application that defines the profile.
        /// </summary>
        field(2; "Profile App ID"; Guid)
        {
            Caption = 'Profile App ID';
        }
        /// <summary>
        /// Code identifier of the user profile.
        /// </summary>
        field(3; "Profile ID"; Code[30])
        {
            Caption = 'Profile ID';
        }
        /// <summary>
        /// Numeric identifier of the page that has profile-specific customizations.
        /// </summary>
        field(4; "Page ID"; Integer)
        {
            Caption = 'Page ID';
        }
        /// <summary>
        /// Name of the extension application containing the page customization.
        /// </summary>
        field(5; "App Name"; Text[250])
        {
            Caption = 'App Name';
        }
        /// <summary>
        /// Publisher of the extension application containing the page customization.
        /// </summary>
        field(6; "App Publisher"; Text[250])
        {
            Caption = 'App Publisher';
        }
        /// <summary>
        /// Name of the extension application that defines the profile.
        /// </summary>
        field(7; "Profile App Name"; Text[250])
        {
            Caption = 'Profile App Name';
        }
        /// <summary>
        /// Publisher of the extension application that defines the profile.
        /// </summary>
        field(8; "Profile App Publisher"; Text[250])
        {
            Caption = 'Profile App Publisher';
        }
    }

    keys
    {
        key(Key1; "App ID", "Profile App ID", "Profile ID", "Page ID")
        {
            Clustered = true;
        }
    }
}