// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Security.AccessControl;

/// <summary>
/// Virtual table that provides metadata about permission sets defined in applications.
/// </summary>
/// <remarks>
/// This table exposes information about permission sets as they are defined in application metadata,
/// providing visibility into the security model structure across all installed applications.
/// Essential for security administrators to understand available permission sets, their assignability,
/// and application relationships. Used by permission management tools and security analysis processes
/// to inventory and manage the permission set landscape in the system.
/// </remarks>
table 2000000250 "Metadata Permission Set"
{
    Caption = 'Metadata Permission Set';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// The application ID that defines this permission set.
        /// </summary>
        field(1; "App ID"; Guid)
        {
            Caption = 'App ID';
        }
        /// <summary>
        /// The unique identifier of the permission set within the application.
        /// </summary>
        field(2; "Role ID"; Code[30])
        {
            Caption = 'Role ID';
        }
        /// <summary>
        /// The display name of the permission set.
        /// </summary>
        field(3; Name; Text[30])
        {
            Caption = 'Name';
        }
        /// <summary>
        /// Indicates whether this permission set can be assigned to users.
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

