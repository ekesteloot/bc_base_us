// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Apps;

/// <summary>
/// Stores add-in resources and metadata for Business Central apps at the tenant level.
/// </summary>
/// <remarks>
/// This table manages add-in components (JavaScript, .NET assemblies, language resources) deployed with Business Central apps.
/// Each record represents a specific add-in resource with its metadata, version information, and binary content.
/// Essential for app runtime functionality, enabling client-side controls, .NET interoperability, and localization resources.
/// </remarks>
table 2000000169 "NAV App Tenant Add-In"
{
    Caption = 'NAV App Tenant Add-In';
    DataPerCompany = false;
    Scope = Cloud;
    ReplicateData = false;

    fields
    {
        /// <summary>
        /// The unique identifier of the app that contains this add-in.
        /// </summary>
        field(1; "App ID"; Guid)
        {
            Caption = 'App ID';
        }
        /// <summary>
        /// The name identifier of the add-in component.
        /// </summary>
        field(2; "Add-In Name"; Text[220])
        {
            Caption = 'Add-In Name';
        }
        /// <summary>
        /// The public key token for .NET assemblies used for security and version verification.
        /// </summary>
        field(3; "Public Key Token"; Text[20])
        {
            Caption = 'Public Key Token';
        }
        /// <summary>
        /// The version number of the add-in component.
        /// </summary>
        field(4; Version; Text[25])
        {
            Caption = 'Version';
        }
        /// <summary>
        /// The category type of the add-in determining its purpose and usage context.
        /// </summary>
        field(5; Category; Option)
        {
            Caption = 'Category';
            OptionCaption = 'JavaScript Control Add-in,DotNet Control Add-in,DotNet Interoperability,Language Resource';
            OptionMembers = "JavaScript Control Add-in","DotNet Control Add-in","DotNet Interoperability","Language Resource";
        }
        /// <summary>
        /// A descriptive text explaining the purpose and functionality of the add-in.
        /// </summary>
        field(6; Description; Text[250])
        {
            Caption = 'Description';
        }
        /// <summary>
        /// The binary content of the add-in resource (JavaScript files, .NET assemblies, or language files).
        /// </summary>
        field(7; Resource; BLOB)
        {
            Caption = 'Resource';
        }
    }

    keys
    {
        key(Key1; "App ID", "Add-In Name", "Public Key Token", Version)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

