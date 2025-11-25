// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Security.AccessControl;
using System.Environment;

/// <summary>
/// Temporary table storing relationship permission sets, and company access rights across the tenant.
/// This can be used to assigned the list of permission sets to assign to a user for access control and security management.
/// </summary>
table 2000000291 "Access Control Buffer"
{
    TableType = Temporary;
    Scope = OnPrem; // TODO(agent) - This should change to Cloud when ready to expose agents.

    fields
    {
        /// <summary>
        /// The company to which the access control assignment applies.
        /// </summary>
        field(1; "Company Name"; Text[30])
        {
            TableRelation = Company.Name;
        }

        /// <summary>
        /// The scope level of the permission set (System or Tenant).
        /// </summary>
        field(2; Scope; Option)
        {
            OptionMembers = System,Tenant;
        }

        /// <summary>
        /// The application ID that defines the permission set.
        /// </summary>
        field(3; "App ID"; Guid)
        {
            TableRelation = "Aggregate Permission Set"."App ID";
        }

        /// <summary>
        /// The unique identifier of the permission set within its scope.
        /// </summary>
        field(4; "Role ID"; Code[20])
        {
            TableRelation = "Aggregate Permission Set"."Role ID";
        }
    }

    keys
    {
        key(pk; "Company Name", Scope, "App ID", "Role ID")
        {
            Clustered = true;
        }
    }
}
