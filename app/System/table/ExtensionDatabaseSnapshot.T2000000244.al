// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Apps;

/// <summary>
/// Virtual table containing snapshot information about extension database states and deployment history.
/// Provides tracking of extension packages, their versions, and deployment status across the platform.
/// </summary>
/// <remarks>
/// This table enables monitoring of extension lifecycle events, version management, and deployment tracking.
/// Used by platform services for extension management, upgrade processes, and dependency resolution.
/// Supports both runtime and development scenarios for extension deployment analysis.
/// </remarks>
table 2000000244 "Extension Database Snapshot"
{
    Caption = 'Extension Database Snapshot';
    DataPerCompany = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Unique identifier of the application extension.
        /// </summary>
        field(1; "App Id"; Guid)
        {
            Caption = 'App ID';
        }

        /// <summary>
        /// Unique identifier of the extension package deployment.
        /// </summary>
        field(2; "Package Id"; Guid)
        {
            Caption = 'Package Id';
        }

        /// <summary>
        /// Display name of the extension application.
        /// </summary>
        field(3; "Name"; Text[80])
        {
            Caption = 'Name';
        }

        /// <summary>
        /// Publisher organization or entity that created the extension.
        /// </summary>
        field(4; "Publisher"; Text[250])
        {
            Caption = 'Publisher';
        }

        /// <summary>
        /// Schema version number of the extension's database structure.
        /// </summary>
        field(5; "Schema Version"; Text[250])
        {
            Caption = 'Schema Version';
        }

        /// <summary>
        /// Runtime package identifier used during execution.
        /// </summary>
        field(6; "Runtime Package Id"; Guid)
        {
            Caption = 'Runtime Package ID';
        }

        /// <summary>
        /// Current deployment status of the extension (Unpublished, Published, Installed).
        /// </summary>
        field(7; "Status"; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Unpublished, Published, Installed';
            OptionMembers = "Unpublished","Published","Installed";
        }

        /// <summary>
        /// The "Published As" option. Indicates how the application was published.
        /// </summary>
        field(8; "Published As"; Option)
        {
            Caption = 'Published As';
            OptionCaption = 'Unpublished, Global, PTE, Dev';
            OptionMembers = "Unpublished","Global","PTE","Dev";
        }
    }

    keys
    {
        key(Key1; "App Id", "Package Id")
        {
            Clustered = true;
        }
    }
}

