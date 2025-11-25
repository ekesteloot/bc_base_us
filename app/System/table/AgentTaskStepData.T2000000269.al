// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents.Internal;

using System.Agents;
using System.Security.AccessControl;

table 2000000269 "Agent Task Step Data"
{
    Caption = 'Agent Task Step Data';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;
    Access = Internal;

    fields
    {
        field(1; "Task ID"; BigInteger)
        {
            Caption = 'Task ID';
            TableRelation = "Agent Task Data".ID;
        }
        field(2; "Step Number"; Integer)
        {
        }
        field(3; "User Security ID"; Guid)
        {
            Caption = 'User Security ID';
            TableRelation = User."User Security ID";
        }
        field(4; "Type"; Enum "Agent Task Step Type")
        {
            Caption = 'Type';
        }
        field(5; "Details"; Blob)
        {
        }
        field(6; Description; Text[2048])
        {
        }
        field(8; "Task Agent User Security ID"; Guid)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Data"."Agent User Security ID" where(ID = field("Task ID")));
        }
        field(9; "Internal Details"; Blob)
        {
            ToolTip = 'Specifies the internal details of the step. These are used by the agent runtime and should not be exposed.';
        }
        field(10; "Client Context"; Blob)
        {
        }
        field(11; "Group ID"; BigInteger)
        {
            ToolTip = 'Specifies the step group this step belongs to.';
            TableRelation = "Agent Task Step Group Data".ID;
            ValidateTableRelation = false;
        }
        field(12; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Data"."Company Name" where(ID = field("Task ID")));
        }
    }

    keys
    {
        key(PK; "Task ID", "Step Number")
        {
            Clustered = true;
        }

        key(GroupID; "Task ID", "Group ID", "Step Number")
        {
        }
    }
}