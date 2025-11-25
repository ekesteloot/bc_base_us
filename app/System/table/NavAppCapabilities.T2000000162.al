// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Apps;

/// <summary>
/// Stores capability definitions for Business Central applications defining the features and functionalities that each app provides.
/// </summary>
/// <remarks>
/// This table manages application capability mappings linking application packages to their specific capabilities for license validation and feature control. Enables granular feature management and capability-based licensing for installed applications. Used by the platform for feature availability checks and license enforcement.
/// </remarks>
table 2000000162 "NAV App Capabilities"
{
    Caption = 'NAV App Capabilities';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Unique identifier of the application package that provides the specified capability.
        /// </summary>
        field(1; "Package ID"; Guid)
        {
            Caption = 'Package ID';
        }
        /// <summary>
        /// Numeric identifier of the specific capability provided by the application package.
        /// </summary>
        field(2; "Capability ID"; Integer)
        {
            Caption = 'Capability ID';
        }
    }

    keys
    {
        key(Key1; "Package ID", "Capability ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

