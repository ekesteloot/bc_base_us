// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Security.AccessControl;

/// <summary>
/// Stores tenant-specific permission sets that define collections of object access rights for user assignment.
/// Manages custom permission sets created by administrators for specific tenant security requirements.
/// </summary>
/// <remarks>
/// This table contains permission sets that can be assigned to users for access control management.
/// Integrates with the permission system, user group assignments, and security role definitions.
/// Used by security administration tools and user management interfaces for rights assignment.
/// </remarks>
table 2000000165 "Tenant Permission Set"
{
    Caption = 'Tenant Permission Set';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// Unique identifier of the extension application that provides this permission set.
        /// </summary>
        field(1; "App ID"; Guid)
        {
            Caption = 'App ID';
        }
        /// <summary>
        /// Code identifier of the permission set role for user assignment.
        /// </summary>
        field(2; "Role ID"; Code[20])
        {
            Caption = 'Role ID';
        }
        /// <summary>
        /// Display name of the permission set for identification in user interfaces.
        /// </summary>
        field(3; Name; Text[30])
        {
            Caption = 'Name';
        }
        /// <summary>
        /// Indicates whether this permission set can be assigned to users by administrators.
        /// </summary>
        field(4; Assignable; Boolean)
        {
            Caption = 'Assignable';
            InitValue = true;
        }
    }

    keys
    {
        key(Key1; "App ID", "Role ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

