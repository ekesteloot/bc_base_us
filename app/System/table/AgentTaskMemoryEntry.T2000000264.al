// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

using System.Security.AccessControl;

table 2000000264 "Agent Task Memory Entry"
{
    Caption = 'Agent Task Memory Entry';
    DataPerCompany = false;
    Scope = OnPrem; // This virtual table is for internal use only

    fields
    {
        field(1; "Task ID"; BigInteger)
        {
            Caption = 'Task ID';
            ToolTip = 'Specifies the unique identifier of the task this entry is a part of.';
            Editable = false;
            TableRelation = "Agent Task".ID;
        }
        field(2; "ID"; Integer)
        {
            Caption = 'ID';
            ToolTip = 'Specifies the entry id.';
            Editable = false;
        }
        field(3; "User Security ID"; Guid)
        {
            Caption = 'User Security ID';
            ToolTip = 'Specifies the security ID of the user that was involved in the entry.';
            Editable = false;
            TableRelation = User."User Security ID";
        }
        field(4; "Type"; Enum "Agent Task Memory Entry Type")
        {
            Caption = 'Type';
            ToolTip = 'Specifies the type of entry.';
            Editable = false;
        }
        field(5; "Details"; Blob)
        {
            Caption = 'Details';
            ToolTip = 'Specifies the entry details.';
        }
        field(6; Description; Text[2048])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the description of the entry.';
        }
        field(7; "User Full Name"; Text[80])
        {
            Caption = 'User Full Name';
            Tooltip = 'Specifies the full name of the user that was involved in the entry.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("User"."Full Name" where("User Security ID" = field("User Security ID")));
        }
    }

    keys
    {
        key(PK; "Task ID", "ID")
        {
            Clustered = true;
        }
    }
}