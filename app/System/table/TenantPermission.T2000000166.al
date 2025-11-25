// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Security.AccessControl;

using System.Reflection;

/// <summary>
/// Stores individual permission definitions for tenant permission sets, defining object-level access rights.
/// Manages detailed permissions for tables, pages, reports, and other Business Central objects within permission sets.
/// </summary>
/// <remarks>
/// This table defines the granular permission entries that comprise tenant permission sets, specifying
/// read, insert, modify, delete, and execute rights for specific objects. Integrates with permission set
/// management, user access control, and security filter applications for fine-grained access control.
/// </remarks>
table 2000000166 "Tenant Permission"
{
    Caption = 'Tenant Permission';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// Unique identifier of the extension application that provides the permission set.
        /// </summary>
        field(1; "App ID"; Guid)
        {
            Caption = 'App ID';
        }
        /// <summary>
        /// Code identifier of the permission set role that contains this permission.
        /// </summary>
        field(2; "Role ID"; Code[20])
        {
            Caption = 'Role ID';
            TableRelation = "Tenant Permission Set"."Role ID" WHERE("App ID" = FIELD("App ID"));
        }
        /// <summary>
        /// Display name of the permission set role (calculated from Tenant Permission Set).
        /// </summary>
        field(3; "Role Name"; Text[30])
        {
            CalcFormula = Lookup("Tenant Permission Set".Name WHERE("App ID" = FIELD("App ID"),
                                                                     "Role ID" = FIELD("Role ID")));
            Caption = 'Role Name';
            FieldClass = FlowField;
        }
        /// <summary>
        /// Type of Business Central object that this permission applies to.
        /// </summary>
        field(4; "Object Type"; Option)
        {
            Caption = 'Object Type';
            OptionMembers = "Table Data","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System",,,,,,,,,;
            OptionCaption = 'Table Data,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,System,,,,,,,,,';
        }
        /// <summary>
        /// Numeric identifier of the specific object that this permission applies to.
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
        /// Display name of the object (calculated from AllObjWithCaption).
        /// </summary>
        field(6; "Object Name"; Text[249])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE("Object Type" = FIELD("Object Type"),
                                                                           "Object ID" = FIELD("Object ID")));
            Caption = 'Object Name';
            FieldClass = FlowField;
        }
        /// <summary>
        /// Read access permission level for the specified object.
        /// </summary>
        field(7; "Read Permission"; Option)
        {
            Caption = 'Read Permission';
            InitValue = Yes;
            OptionCaption = ' ,Yes,Indirect';
            OptionMembers = " ",Yes,Indirect;
        }
        /// <summary>
        /// Insert access permission level for the specified object.
        /// </summary>
        field(8; "Insert Permission"; Option)
        {
            Caption = 'Insert Permission';
            InitValue = Yes;
            OptionCaption = ' ,Yes,Indirect';
            OptionMembers = " ",Yes,Indirect;
        }
        /// <summary>
        /// Modify access permission level for the specified object.
        /// </summary>
        field(9; "Modify Permission"; Option)
        {
            Caption = 'Modify Permission';
            InitValue = Yes;
            OptionCaption = ' ,Yes,Indirect';
            OptionMembers = " ",Yes,Indirect;
        }
        /// <summary>
        /// Delete access permission level for the specified object.
        /// </summary>
        field(10; "Delete Permission"; Option)
        {
            Caption = 'Delete Permission';
            InitValue = Yes;
            OptionCaption = ' ,Yes,Indirect';
            OptionMembers = " ",Yes,Indirect;
        }
        /// <summary>
        /// Execute access permission level for the specified object.
        /// </summary>
        field(11; "Execute Permission"; Option)
        {
            Caption = 'Execute Permission';
            InitValue = Yes;
            OptionCaption = ' ,Yes,Indirect';
            OptionMembers = " ",Yes,Indirect;
        }
        /// <summary>
        /// Security filter expression that restricts data access within the permitted object.
        /// </summary>
        field(12; "Security Filter"; TableFilter)
        {
            Caption = 'Security Filter';
        }
        /// <summary>
        /// Permission type indicating whether this is an include or exclude permission rule.
        /// </summary>
        field(13; Type; Option)
        {
            Caption = 'Type';
            OptionMembers = Include,Exclude;
            OptionCaption = 'Include,Exclude';
            InitValue = Include;
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
    }
}

