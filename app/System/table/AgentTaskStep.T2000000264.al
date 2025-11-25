// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

using System.Security.AccessControl;

table 2000000264 "Agent Task Step"
{
    Caption = 'Agent Task Step';
    DataPerCompany = false;
    Scope = OnPrem; // TODO(agent) - This should change to Cloud when ready to expose agents.

    fields
    {
        field(1; "Task ID"; BigInteger)
        {
            Caption = 'Task ID';
            ToolTip = 'Specifies the unique identifier of the task this step is a part of.';
            Editable = false;
            TableRelation = "Agent Task".ID;
        }
        field(2; "Step Number"; Integer)
        {
            Caption = 'Step Number';
            ToolTip = 'Specifies the step number.';
            Editable = false;
        }
        field(3; "User Security ID"; Guid)
        {
            Caption = 'User Security ID';
            ToolTip = 'Specifies the security ID of the user that was involved in performing the step.';
            Editable = false;
            TableRelation = User."User Security ID";
        }
        field(4; "Type"; Enum "Agent Task Step Type")
        {
            Caption = 'Type';
            ToolTip = 'Specifies the type of step.';
            Editable = false;
        }
        field(5; "Details"; Blob)
        {
            Caption = 'Details';
            ToolTip = 'Specifies the step details.';
        }
        field(6; Description; Text[2048])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the description of the step.';
        }
        field(7; "User Full Name"; Text[80])
        {
            Caption = 'User Full Name';
            Tooltip = 'Specifies the full name of the user that was involved in performing the step..';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("User"."Full Name" where("User Security ID" = field("User Security ID")));
        }
    }

    keys
    {
        key(PK; "Task ID", "Step Number")
        {
            Clustered = true;
        }
    }
}