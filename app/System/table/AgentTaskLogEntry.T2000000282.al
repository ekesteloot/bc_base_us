// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

using System.Security.AccessControl;

table 2000000282 "Agent Task Log Entry"
{
    Caption = 'Agent Task Log Entry';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        field(1; "Task ID"; BigInteger)
        {
            Caption = 'Task ID';
            ToolTip = 'Specifies the unique identifier of the task this log entry is a part of.';
            Editable = false;
            TableRelation = "Agent Task".ID;
        }
        field(2; "ID"; Integer)
        {
            Caption = 'ID';
            Editable = false;
        }
        field(3; "User Security ID"; Guid)
        {
            Caption = 'User Security ID';
            ToolTip = 'Specifies the security ID of the user that was involved in the log entry.';
            Editable = false;
            TableRelation = User."User Security ID";
        }
        field(4; "Type"; Enum "Agent Task Log Entry Type")
        {
            Caption = 'Type';
            ToolTip = 'Specifies the log entry type.';
            Editable = false;
        }
        field(5; "Details"; Blob)
        {
            Caption = 'Details';
            ToolTip = 'Specifies additional details of the log entry.';
        }
        field(6; "Description"; Text[2048])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the description of the log entry.';
        }
        field(7; "Level"; Option)
        {
            Caption = 'Level';
            ToolTip = 'Specifies the level of the log entry.';
            OptionCaption = 'Information,Warning,Error';
            OptionMembers = Information,Warning,Error;
        }
        field(8; "Page Caption"; Text[150])
        {
            Caption = 'Page Caption';
            ToolTip = 'Specifies the caption of the page associated with the log entry, if any.';
        }
        field(9; "User Full Name"; Text[80])
        {
            Caption = 'User Full Name';
            Tooltip = 'Specifies the full name of the user that was involved in the log entry.';
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