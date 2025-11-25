// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment.Configuration;

/// <summary>
/// Virtual table that provides information about profile extensions installed in the system.
/// This table enables discovery and management of profile customizations and their source applications.
/// </summary>
/// <remarks>
/// The All Profile Extension table provides information about profile extensions
/// that customize or extend existing user profiles in Business Central. It tracks the relationship
/// between profile extensions and their base profiles, including the applications that provide
/// both the extension and the original profile. This table is essential for profile management,
/// understanding customization layers, and maintaining profile dependencies across multiple
/// applications. It supports administrative scenarios where profile extensions need to be
/// monitored, managed, or troubleshot across complex multi-app environments.
/// </remarks>
table 2000000085 "All Profile Extension"
{
    Caption = 'All Profile Extension';
    DataPerCompany = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// The application identifier that contains the profile extension.
        /// </summary>
        field(1; "App ID"; Guid)
        {
            Caption = 'App ID';
        }
        /// <summary>
        /// The application identifier that contains the base profile being extended.
        /// </summary>
        field(2; "Profile App ID"; Guid)
        {
            Caption = 'Profile App ID';
        }
        /// <summary>
        /// The unique identifier of the profile being extended.
        /// </summary>
        field(3; "Profile ID"; Code[30])
        {
            Caption = 'Profile ID';
        }
        /// <summary>
        /// The name of the application that contains the profile extension.
        /// </summary>
        field(4; "App Name"; Text[250])
        {
            Caption = 'App Name';
        }
        /// <summary>
        /// The publisher of the application that contains the profile extension.
        /// </summary>
        field(5; "App Publisher"; Text[250])
        {
            Caption = 'App Publisher';
        }
        /// <summary>
        /// The name of the application that contains the base profile being extended.
        /// </summary>
        field(6; "Profile App Name"; Text[250])
        {
            Caption = 'Profile App Name';
        }
        /// <summary>
        /// The publisher of the application that contains the base profile being extended.
        /// </summary>
        field(7; "Profile App Publisher"; Text[250])
        {
            Caption = 'Profile App Publisher';
        }
    }

    keys
    {
        key(Key1; "App ID", "Profile App ID", "Profile ID")
        {
            Clustered = true;
        }
    }
}