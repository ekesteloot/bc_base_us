// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Security.AccessControl;

/// <summary>
/// Stores user-to-permission set assignments for access control and security management.
/// Manages the relationship between users, permission sets, and company access rights across the tenant.
/// </summary>
/// <remarks>
/// This table serves as the central repository for user access control assignments, linking users
/// to permission sets within specific companies and application scopes. Integrates with user management,
/// permission set definitions, and company security boundaries for access control.
/// </remarks>
table 2000000053 "Access Control"
{
    Caption = 'Access Control';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// Unique identifier of the user to whom the permission set is assigned.
        /// </summary>
        field(1; "User Security ID"; Guid)
        {
            Caption = 'User Security ID';
            TableRelation = User."User Security ID";
        }
        /// <summary>
        /// Code identifier of the permission set role being assigned to the user.
        /// </summary>
        field(2; "Role ID"; Code[20])
        {
            Caption = 'Role ID';
            TableRelation = "Aggregate Permission Set"."Role ID";
        }
        /// <summary>
        /// Name of the company where the permission set assignment applies.
        /// </summary>
        field(3; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            TableRelation = System.Environment.Company.Name;
        }
        /// <summary>
        /// Login name of the user (calculated from User table).
        /// </summary>
        field(5; "User Name"; Code[50])
        {
            CalcFormula = Lookup(User."User Name" WHERE("User Security ID" = FIELD("User Security ID")));
            Caption = 'User Name';
            FieldClass = FlowField;
        }
        /// <summary>
        /// Display name of the permission set role (calculated from Aggregate Permission Set).
        /// </summary>
        field(7; "Role Name"; Text[30])
        {
            CalcFormula = Lookup("Aggregate Permission Set".Name WHERE(Scope = FIELD(Scope),
                                                                        "App ID" = FIELD("App ID"),
                                                                        "Role ID" = FIELD("Role ID")));
            Caption = 'Role Name';
            FieldClass = FlowField;
        }
        /// <summary>
        /// Scope of the permission set (System or Tenant level).
        /// </summary>
        field(8; Scope; Option)
        {
            Caption = 'Scope';
            OptionCaption = 'System,Tenant';
            OptionMembers = System,Tenant;
            TableRelation = "Aggregate Permission Set".Scope;
        }
        /// <summary>
        /// Unique identifier of the extension application that provides the permission set.
        /// </summary>
        field(9; "App ID"; Guid)
        {
            Caption = 'App ID';
            TableRelation = "Aggregate Permission Set"."App ID";
        }
        /// <summary>
        /// Name of the extension application (calculated from Aggregate Permission Set).
        /// </summary>
        field(10; "App Name"; Text[250])
        {
            CalcFormula = Lookup("Aggregate Permission Set"."App Name" WHERE(Scope = FIELD(Scope),
                                                                              "App ID" = FIELD("App ID"),
                                                                              "Role ID" = FIELD("Role ID")));
            Caption = 'App Name';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "User Security ID", "Role ID", "Company Name", Scope, "App ID")
        {
            Clustered = true;
        }
        key(Key2; "Role ID")
        {
        }
    }

    fieldgroups
    {
    }
}

