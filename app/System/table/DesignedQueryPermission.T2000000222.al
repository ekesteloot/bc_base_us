// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Tooling;

using System.Security.AccessControl;

/// <summary>
/// Stores permission settings for designed queries, managing access control for query objects by role.
/// </summary>
/// <remarks>
/// This table manages security permissions for designed query objects, defining which roles can read or execute specific queries.
/// Each record represents a permission assignment between a role and a designed query object.
/// Essential for query security, ensuring proper access control and data protection in designed query frameworks.
/// </remarks>
table 2000000222 "Designed Query Permission"
{
    Caption = 'Designed Query Permission';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// The unique identifier of the app that contains the permission set role.
        /// </summary>
        field(1; "App ID"; Guid)
        {
            Caption = 'App ID';
        }
        /// <summary>
        /// The identifier of the role that the permission applies to.
        /// </summary>
        field(2; "Role ID"; Code[20])
        {
            Caption = 'Role ID';
            TableRelation = "Tenant Permission Set"."Role ID" WHERE("App ID" = FIELD("App ID"));
        }
        /// <summary>
        /// The name of the role that the permission applies to.
        /// </summary>
        field(3; "Role Name"; Text[30])
        {
            CalcFormula = Lookup("Tenant Permission Set".Name WHERE("App ID" = FIELD("App ID"),
                                                                     "Role ID" = FIELD("Role ID")));
            Caption = 'Role Name';
            FieldClass = FlowField;
        }
        /// <summary>
        /// The identifier of the designed query object that the permission applies to.
        /// </summary>
        field(4; "Object ID"; Integer)
        {
            Caption = 'Object ID';
            TableRelation = "Designed Query Obj"."Object ID";
        }
        /// <summary>
        /// The name of the designed query object that the permission applies to.
        /// </summary>
        field(5; "Object Name"; Text[30])
        {
            CalcFormula = Lookup("Designed Query Obj"."Object Name" WHERE("Object ID" = FIELD("Object ID")));
            Caption = 'Object Name';
            FieldClass = FlowField;
        }
        /// <summary>
        /// The read permission level granted for this designed query object.
        /// </summary>
        field(6; "Read Permission"; Option)
        {
            Caption = 'Read Permission';
            InitValue = Yes;
            OptionCaption = ' ,Yes,Indirect';
            OptionMembers = " ",Yes,Indirect;
        }
        /// <summary>
        /// The insert permission level granted for this designed query object.
        /// </summary>
        field(7; "Insert Permission"; Option)
        {
            Caption = 'Insert Permission';
            OptionCaption = ' ,Yes,Indirect';
            OptionMembers = " ",Yes,Indirect;
        }
        /// <summary>
        /// The modify permission level granted for this designed query object.
        /// </summary>
        field(8; "Modify Permission"; Option)
        {
            Caption = 'Modify Permission';
            OptionCaption = ' ,Yes,Indirect';
            OptionMembers = " ",Yes,Indirect;
        }
        /// <summary>
        /// The delete permission level granted for this designed query object.
        /// </summary>
        field(9; "Delete Permission"; Option)
        {
            Caption = 'Delete Permission';
            OptionCaption = ' ,Yes,Indirect';
            OptionMembers = " ",Yes,Indirect;
        }
        /// <summary>
        /// The execute permission level granted for this designed query object.
        /// </summary>
        field(10; "Execute Permission"; Option)
        {
            Caption = 'Execute Permission';
            InitValue = Yes;
            OptionCaption = ' ,Yes,Indirect';
            OptionMembers = " ",Yes,Indirect;
        }
    }

    keys
    {
        key(PK; "App ID", "Role ID", "Object ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

