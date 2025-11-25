// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Security.AccessControl;

/// <summary>
/// Defines granular permissions for Business Central objects within entitlement sets, controlling access rights for specific object types and ID ranges.
/// </summary>
/// <remarks>
/// This table manages object-level permissions including read, insert, modify, delete, and execute rights for tables, pages, reports, codeunits, and other objects. Supports range-based permissions for permission management and integrates with entitlement sets for license-based access control. Used by the security system for runtime permission validation.
/// </remarks>
table 2000000191 Entitlement
{
    Caption = 'Entitlement';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Identifier of the entitlement set that contains this permission definition.
        /// </summary>
        field(1; "Entitlement Set ID"; Code[20])
        {
            Caption = 'Entitlement Set ID';
            TableRelation = "Entitlement Set".ID WHERE(ID = FIELD("Entitlement Set ID"));
        }
        /// <summary>
        /// Display name of the entitlement set for user identification and administrative purposes.
        /// </summary>
        field(2; "Entitlement Set Name"; Text[250])
        {
            CalcFormula = Lookup("Entitlement Set".Name WHERE(ID = FIELD("Entitlement Set ID")));
            Caption = 'Entitlement Set Name';
            FieldClass = FlowField;
        }
        /// <summary>
        /// Type of Business Central object that this permission applies to including tables, pages, reports, codeunits, and extensions.
        /// </summary>
        field(3; "Object Type"; Option)
        {
            Caption = 'Object Type';
            OptionMembers = "Table Data","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System",,,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension","PermissionSet","PermissionSetExtension","ReportExtension";
            OptionCaption = 'Table Data,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,System,,,,PageExtension,TableExtension,Enum,EnumExtension,Profile,ProfileExtension,PermissionSet,PermissionSetExtension,ReportExtension';
        }
        /// <summary>
        /// Starting object ID for the permission range enabling permission management across object ID ranges.
        /// </summary>
        field(4; "Object ID Range Start"; Integer)
        {
            Caption = 'Object ID Range Start';
        }
        /// <summary>
        /// Ending object ID for the permission range defining the upper boundary of objects covered by this permission.
        /// </summary>
        field(5; "Object ID Range End"; Integer)
        {
            Caption = 'Object ID Range End';
        }
        /// <summary>
        /// Read access permission level controlling data retrieval and viewing capabilities for the specified objects.
        /// </summary>
        field(6; "Read Permission"; Option)
        {
            Caption = 'Read Permission';
            InitValue = Yes;
            OptionCaption = ' ,Yes,Indirect';
            OptionMembers = " ",Yes,Indirect;
        }
        /// <summary>
        /// Insert access permission level controlling new record creation capabilities for the specified objects.
        /// </summary>
        field(7; "Insert Permission"; Option)
        {
            Caption = 'Insert Permission';
            InitValue = Yes;
            OptionCaption = ' ,Yes,Indirect';
            OptionMembers = " ",Yes,Indirect;
        }
        /// <summary>
        /// Modify access permission level controlling record update and editing capabilities for the specified objects.
        /// </summary>
        field(8; "Modify Permission"; Option)
        {
            Caption = 'Modify Permission';
            InitValue = Yes;
            OptionCaption = ' ,Yes,Indirect';
            OptionMembers = " ",Yes,Indirect;
        }
        /// <summary>
        /// Delete access permission level controlling record removal capabilities for the specified objects.
        /// </summary>
        field(9; "Delete Permission"; Option)
        {
            Caption = 'Delete Permission';
            InitValue = Yes;
            OptionCaption = ' ,Yes,Indirect';
            OptionMembers = " ",Yes,Indirect;
        }
        /// <summary>
        /// Execute access permission level controlling procedure execution and object invocation capabilities for the specified objects.
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
        key(Key1; "Entitlement Set ID", "Object Type", "Object ID Range Start", "Object ID Range End")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

