// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Security.AccessControl;

using System.Reflection;

/// <summary>
/// Virtual table that provides detailed metadata about individual permissions within permission sets.
/// </summary>
/// <remarks>
/// This table exposes the granular permission definitions that make up permission sets, including
/// object-level permissions for tables, reports, codeunits, pages, and other AL objects.
/// Essential for security analysis, permission auditing, and compliance reporting. Used by security
/// administrators to understand the exact permissions granted by each permission set and to analyze
/// the security model at a detailed level. The table includes both include and exclude permissions
/// along with security filters for fine-grained access control.
/// </remarks>
table 2000000251 "Metadata Permission"
{
    Caption = 'Metadata Permission';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// The application ID that defines this permission.
        /// </summary>
        field(1; "App ID"; Guid)
        {
            Caption = 'App ID';
        }
        /// <summary>
        /// The role ID of the permission set that contains this permission.
        /// </summary>
        field(2; "Role ID"; Code[30])
        {
            Caption = 'Role ID';
            TableRelation = "Metadata Permission Set"."Role ID" WHERE("App ID" = FIELD("App ID"));
        }
        /// <summary>
        /// The display name of the permission set that contains this permission.
        /// </summary>
        field(3; "Role Name"; Text[30])
        {
            CalcFormula = Lookup("Metadata Permission Set".Name WHERE("App ID" = FIELD("App ID"),
                                                                      "Role ID" = FIELD("Role ID")));
            Caption = 'Role Name';
            FieldClass = FlowField;
        }
        /// <summary>
        /// The type of AL object that this permission applies to.
        /// </summary>
        field(4; "Object Type"; Option)
        {
            Caption = 'Object Type';
            OptionMembers = "Table Data","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System",,,,,,,,,;
            OptionCaption = 'Table Data,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,System,,,,,,,,,';
        }
        /// <summary>
        /// The ID of the specific object that this permission applies to.
        /// </summary>
        field(5; "Object ID"; Integer)
        {
            Caption = 'Object ID';
            TableRelation = IF ("Object Type" = CONST("Table Data")) AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Table))
            ELSE
            IF ("Object Type" = CONST(Table)) AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Table))
            ELSE
            IF ("Object Type" = CONST(Report)) AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Report))
            ELSE
            IF ("Object Type" = CONST(Codeunit)) AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Codeunit))
            ELSE
            IF ("Object Type" = CONST(XMLport)) AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(XMLport))
            ELSE
            IF ("Object Type" = CONST(MenuSuite)) AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(MenuSuite))
            ELSE
            IF ("Object Type" = CONST(Page)) AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Page))
            ELSE
            IF ("Object Type" = CONST(Query)) AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Query))
            ELSE
            IF ("Object Type" = CONST(System)) AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(System));
        }
        /// <summary>
        /// The display name or caption of the object that this permission applies to.
        /// </summary>
        field(6; "Object Name"; Text[249])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE("Object Type" = FIELD("Object Type"),
                                                                           "Object ID" = FIELD("Object ID")));
            Caption = 'Object Name';
            FieldClass = FlowField;
        }
        /// <summary>
        /// The read permission level granted for this object (blank, Yes, or Indirect).
        /// </summary>
        field(7; "Read Permission"; Option)
        {
            Caption = 'Read Permission';
            InitValue = Yes;
            OptionCaption = ' ,Yes,Indirect';
            OptionMembers = " ",Yes,Indirect;
        }
        /// <summary>
        /// The insert permission level granted for this object (blank, Yes, or Indirect).
        /// </summary>
        field(8; "Insert Permission"; Option)
        {
            Caption = 'Insert Permission';
            InitValue = Yes;
            OptionCaption = ' ,Yes,Indirect';
            OptionMembers = " ",Yes,Indirect;
        }
        /// <summary>
        /// The modify permission level granted for this object (blank, Yes, or Indirect).
        /// </summary>
        field(9; "Modify Permission"; Option)
        {
            Caption = 'Modify Permission';
            InitValue = Yes;
            OptionCaption = ' ,Yes,Indirect';
            OptionMembers = " ",Yes,Indirect;
        }
        /// <summary>
        /// The delete permission level granted for this object (blank, Yes, or Indirect).
        /// </summary>
        field(10; "Delete Permission"; Option)
        {
            Caption = 'Delete Permission';
            InitValue = Yes;
            OptionCaption = ' ,Yes,Indirect';
            OptionMembers = " ",Yes,Indirect;
        }
        /// <summary>
        /// The execute permission level granted for this object (blank, Yes, or Indirect).
        /// </summary>
        field(11; "Execute Permission"; Option)
        {
            Caption = 'Execute Permission';
            InitValue = Yes;
            OptionCaption = ' ,Yes,Indirect';
            OptionMembers = " ",Yes,Indirect;
        }
        /// <summary>
        /// Whether this permission is included or excluded from the permission set.
        /// </summary>
        field(12; Type; Option)
        {
            Caption = 'Type';
            OptionMembers = Include,Exclude;
            OptionCaption = 'Include,Exclude';
            InitValue = Include;
        }
        /// <summary>
        /// Indicates whether the permission set containing this permission can be assigned to users.
        /// </summary>
        field(13; Assignable; Boolean)
        {
            CalcFormula = Lookup("Metadata Permission Set".Assignable WHERE("App ID" = FIELD("App ID"),
                                                                            "Role ID" = FIELD("Role ID")));
            Caption = 'Assignable';
            FieldClass = FlowField;
        }
        /// <summary>
        /// The security filter that restricts access to specific records within the object.
        /// </summary>
        field(14; "Security Filter"; TableFilter)
        {
            Caption = 'Security Filter';
        }
        /// <summary>
        /// The AL object name as defined in the source code.
        /// </summary>
        field(15; "AL Object Name"; Text[30])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Name" WHERE("Object Type" = FIELD("Object Type"),
                                                                           "Object ID" = FIELD("Object ID")));
            Caption = 'AL Object Name';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "App ID", "Role ID", "Object Type", "Object ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "App ID", "Role ID", "Role Name")
        {
        }
    }
}

