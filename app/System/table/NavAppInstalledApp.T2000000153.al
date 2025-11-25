// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Apps;

/// <summary>
/// Stores metadata for Business Central applications (extensions) that are currently installed in the tenant.
/// </summary>
/// <remarks>
/// This table maintains a registry of all installed applications with their version information, compatibility details,
/// and publishing metadata. It tracks application identity through App ID and Package ID, provides version control
/// through major/minor/build/revision numbers, and stores compatibility requirements. The table supports different
/// extension types and publishing modes (Global, PTE, Dev) for proper application lifecycle management.
/// Used by the application management framework for version tracking, compatibility checking, and deployment management.
/// </remarks>
table 2000000153 "NAV App Installed App"
{
    Caption = 'NAV App Installed App';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// Unique identifier for the application.
        /// </summary>
        field(1; "App ID"; Guid)
        {
            Caption = 'App ID';
        }
        /// <summary>
        /// Unique identifier for the specific package version of the application.
        /// </summary>
        field(2; "Package ID"; Guid)
        {
            Caption = 'Package ID';
        }
        /// <summary>
        /// Display name of the application.
        /// </summary>
        field(3; Name; Text[250])
        {
            Caption = 'Name';
        }
        /// <summary>
        /// Publisher name of the application.
        /// </summary>
        field(4; Publisher; Text[250])
        {
            Caption = 'Publisher';
        }
        /// <summary>
        /// Major version number of the application.
        /// </summary>
        field(5; "Version Major"; Integer)
        {
            Caption = 'Version Major';
        }
        /// <summary>
        /// Minor version number of the application.
        /// </summary>
        field(6; "Version Minor"; Integer)
        {
            Caption = 'Version Minor';
        }
        /// <summary>
        /// Build version number of the application.
        /// </summary>
        field(7; "Version Build"; Integer)
        {
            Caption = 'Version Build';
        }
        /// <summary>
        /// Revision version number of the application.
        /// </summary>
        field(8; "Version Revision"; Integer)
        {
            Caption = 'Version Revision';
        }
        /// <summary>
        /// Major compatibility version requirement for the application.
        /// </summary>
        field(9; "Compatibility Major"; Integer)
        {
            Caption = 'Compatibility Major';
        }
        /// <summary>
        /// Minor compatibility version requirement for the application.
        /// </summary>
        field(10; "Compatibility Minor"; Integer)
        {
            Caption = 'Compatibility Minor';
        }
        /// <summary>
        /// Build compatibility version requirement for the application.
        /// </summary>
        field(11; "Compatibility Build"; Integer)
        {
            Caption = 'Compatibility Build';
        }
        /// <summary>
        /// Revision compatibility version requirement for the application.
        /// </summary>
        field(12; "Compatibility Revision"; Integer)
        {
            Caption = 'Compatibility Revision';
        }
        /// <summary>
        /// Hash value of the application content for integrity verification.
        /// </summary>
        field(13; "Content Hash"; Text[250])
        {
            Caption = 'Content Hash';
        }
        /// <summary>
        /// Algorithm identifier used for content hash calculation.
        /// </summary>
        field(14; "Hash Algorithm"; Integer)
        {
            Caption = 'Hash Algorithm';
        }
        /// <summary>
        /// Type classification of the extension defining its characteristics and behavior.
        /// </summary>
        field(15; "Extension Type"; Integer)
        {
            Caption = 'Extension Type';
        }
        /// <summary>
        /// Publication mode indicating how the application was published (Global, PTE, or Dev).
        /// </summary>
        field(16; "Published As"; Option)
        {
            Caption = 'Published As';
            OptionCaption = 'Global, PTE, Dev';
            OptionMembers = "Global","PTE","Dev";
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

