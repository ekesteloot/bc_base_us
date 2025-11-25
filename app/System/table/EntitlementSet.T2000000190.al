// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Security.AccessControl;

/// <summary>
/// Defines named collections of entitlements that group related permissions for license-based access control and user role management.
/// </summary>
/// <remarks>
/// This table manages entitlement set definitions that contain collections of object permissions for different license types and user roles. Provides the foundation for license-based security by grouping related permissions into logical sets. Used by the security system for permission management and license enforcement.
/// </remarks>
table 2000000190 "Entitlement Set"
{
    Caption = 'Entitlement Set';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Unique identifier for the entitlement set used for referencing and linking individual entitlements.
        /// </summary>
        field(1; ID; Code[20])
        {
            Caption = 'ID';
        }
        /// <summary>
        /// Descriptive name for the entitlement set used for identification and administrative purposes.
        /// </summary>
        field(2; Name; Text[250])
        {
            Caption = 'Name';
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

