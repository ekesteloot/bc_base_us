// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Security.AccessControl;

/// <summary>
/// Virtual table that defines relationships between metadata permission sets, including inclusions and exclusions.
/// </summary>
/// <remarks>
/// This table manages the hierarchical and compositional relationships between permission sets,
/// allowing permission sets to include or exclude other permission sets. Essential for implementing
/// permission set inheritance, composition, and complex security models. Used by the security framework
/// to resolve effective permissions by processing include and exclude relationships between permission sets.
/// Enables building sophisticated permission structures through permission set composition.
/// </remarks>
table 2000000252 "Metadata Permission Set Rel."
{
    Caption = 'Metadata Permission Set Rel.';
    DataPerCompany = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// The application ID of the permission set that defines this relationship.
        /// </summary>
        field(1; "App ID"; Guid)
        {
            Caption = 'App ID';
        }
        /// <summary>
        /// The role ID of the permission set that defines this relationship.
        /// </summary>
        field(2; "Role ID"; Code[30])
        {
            Caption = 'Role ID';
        }
        /// <summary>
        /// The application ID of the related permission set being included or excluded.
        /// </summary>
        field(3; "Related App ID"; Guid)
        {
            Caption = 'Related App ID';
        }
        /// <summary>
        /// The role ID of the related permission set being included or excluded.
        /// </summary>
        field(4; "Related Role ID"; Code[30])
        {
            Caption = 'Related Role ID';
        }
        /// <summary>
        /// The type of relationship (Include or Exclude) between the permission sets.
        /// </summary>
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionMembers = Include,Exclude;
            OptionCaption = 'Include,Exclude';
            InitValue = Include;
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

