// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Reflection;

/// <summary>
/// Stores metadata and resources for add-ins including JavaScript controls, .NET controls, and language resources used throughout the Business Central application.
/// </summary>
/// <remarks>
/// This table manages add-in registration and versioning for control add-ins, .NET interoperability components, and language resources. Used by the platform for dynamic add-in loading and resource management.
/// </remarks>
table 2000000069 "Add-in"
{
    Caption = 'Add-in';
    DataPerCompany = false;
    Scope = Cloud;
    InherentPermissions = rX;

    fields
    {
        /// <summary>
        /// Unique name identifier for the add-in component.
        /// </summary>
        field(1; "Add-in Name"; Text[220])
        {
            Caption = 'Add-in Name';
        }
        /// <summary>
        /// Public key token used for add-in assembly verification and security validation.
        /// </summary>
        field(5; "Public Key Token"; Text[20])
        {
            Caption = 'Public Key Token';
        }
        /// <summary>
        /// Version number of the add-in for compatibility tracking and update management.
        /// </summary>
        field(8; Version; Text[25])
        {
            Caption = 'Version';
        }
        /// <summary>
        /// Category classification defining the add-in type and functionality scope.
        /// </summary>
        field(15; Category; Option)
        {
            Caption = 'Category';
            OptionCaption = 'JavaScript Control Add-in,DotNet Control Add-in,DotNet Interoperability,Language Resource';
            OptionMembers = "JavaScript Control Add-in","DotNet Control Add-in","DotNet Interoperability","Language Resource";
        }
        /// <summary>
        /// Descriptive text explaining the add-in purpose and functionality.
        /// </summary>
        field(20; Description; Text[250])
        {
            Caption = 'Description';
        }
        /// <summary>
        /// Binary content containing the add-in resources, assemblies, or script files.
        /// </summary>
        field(25; Resource; BLOB)
        {
            Caption = 'Resource';
        }
    }

    keys
    {
        key(Key1; "Add-in Name", "Public Key Token", Version)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

