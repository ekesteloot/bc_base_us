// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Security.AccessControl;

/// <summary>
/// Virtual table that provides an aggregated view of permission sets across different scopes and applications.
/// </summary>
/// <remarks>
/// This table combines permission sets from both system and tenant scopes, providing a unified view
/// for permission management and analysis. Essential for security administrators to understand the
/// complete permission landscape across all applications and scopes. Used by permission management
/// tools to display and manage permission sets regardless of their origin or scope.
/// The table enables permission set discovery and administration.
/// </remarks>
table 2000000167 "Aggregate Permission Set"
{
    DataPerCompany = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// The scope level of the permission set (System or Tenant).
        /// </summary>
        field(1; Scope; Option)
        {
            OptionMembers = System,Tenant;
        }
        /// <summary>
        /// The application ID that defines this permission set.
        /// </summary>
        field(2; "App ID"; Guid)
        {
        }
        /// <summary>
        /// The unique identifier of the permission set within its scope.
        /// </summary>
        field(3; "Role ID"; Code[20])
        {
        }
        /// <summary>
        /// The display name of the permission set.
        /// </summary>
        field(4; Name; Text[30])
        {
        }
        /// <summary>
        /// The name of the application that provides this permission set.
        /// </summary>
        field(5; "App Name"; Text[250])
        {
        }
    }
    keys
    {
        key(pk; Scope, "App ID", "Role ID")
        {
        }
    }

    fieldgroups
    {
        fieldgroup("DropDown"; "Role ID", Name, "App Name")
        {

        }
    }
}