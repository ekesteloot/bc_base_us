// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Security.AccessControl;

/// <summary>
/// Defines relationships between tenant permission sets, enabling hierarchical permission structures through include and exclude relationships.
/// This table supports complex permission inheritance scenarios and permission set composition at the tenant level.
/// </summary>
/// <remarks>
/// This table establishes relationships between permission sets, allowing one permission set to include or exclude permissions from another.
/// Supports both system-level and tenant-level permission set relationships for flexible security management.
/// Data is not company-specific to ensure consistent permission relationships across the tenant.
/// Extensibility points include custom permission composition logic and relationship validation events.
/// Related tables: Tenant Permission Set, Metadata Permission Set for permission definitions.
/// </remarks>
table 2000000253 "Tenant Permission Set Rel."
{
    Caption = 'Tenant Permission Set Rel.';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// Application identifier of the parent permission set that contains the relationship definition.
        /// </summary>
        field(1; "App ID"; Guid)
        {
            Caption = 'App ID';
            TableRelation = "Tenant Permission Set"."App ID";
        }
        /// <summary>
        /// Role identifier of the parent permission set that defines the relationship to other permission sets.
        /// </summary>
        field(2; "Role ID"; Code[30])
        {
            Caption = 'Role ID';
            TableRelation = "Tenant Permission Set"."Role ID";
        }
        /// <summary>
        /// Application identifier of the related permission set that is being included or excluded by the parent permission set.
        /// </summary>
        field(3; "Related App ID"; Guid)
        {
            Caption = 'Related App ID';
            TableRelation = IF ("Related Scope" = CONST(System))
            "Metadata Permission Set"."App ID" WHERE("Role ID" = FIELD("Related Role ID"))
            ELSE
            "Tenant Permission Set"."App ID" WHERE("Role ID" = FIELD("Related Role ID"));
        }
        /// <summary>
        /// Role identifier of the related permission set that is being included or excluded in the relationship.
        /// </summary>
        field(4; "Related Role ID"; Code[30])
        {
            Caption = 'Related Role ID';
            TableRelation = IF ("Related Scope" = CONST(System)) "Metadata Permission Set"."Role ID" ELSE
            "Tenant Permission Set"."Role ID";
        }
        /// <summary>
        /// Defines whether the relationship includes or excludes the related permission set's permissions from the parent permission set.
        /// </summary>
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionMembers = Include,Exclude;
            OptionCaption = 'Include,Exclude';
            InitValue = Include;
        }
        /// <summary>
        /// Specifies whether the related permission set is at the system level or tenant level, determining the source of permission definitions.
        /// </summary>
        field(6; "Related Scope"; Option)
        {
            Caption = 'Related Scope';
            OptionMembers = System,Tenant;
            OptionCaption = 'System,Tenant';
        }
    }

    keys
    {
        key(Key1; "App ID", "Role ID", "Related App ID", "Related Role ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

