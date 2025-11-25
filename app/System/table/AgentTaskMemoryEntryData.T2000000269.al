// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents.Internal;

using System.Agents;
using System.Security.AccessControl;

table 2000000269 "Agent Task Memory Entry Data"
{
    Caption = 'Agent Task Memory Entry Data';
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
        field(2; "ID"; Integer)
        {
        }
        field(3; "User Security ID"; Guid)
        {
            Caption = 'User Security ID';
            TableRelation = User."User Security ID";
        }
        field(4; "Type"; Enum "Agent Task Memory Entry Type")
        {
            Caption = 'Type';
        }
        field(5; "Details"; Blob)
        {
        }
        field(6; Description; Text[2048])
        {
        }
        field(7; "Task Agent User Security ID"; Guid)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Data"."Agent User Security ID" where(ID = field("Task ID")));
        }
        field(8; "Internal Details"; Blob)
        {
            ToolTip = 'Specifies the internal details of the entry. These are used by the agent runtime and should not be exposed.';
        }
        field(9; "Related Record ID"; RecordId)
        {
            ToolTip = 'Specifies the optional record related to this memory entry, e.g. an incoming message, a record created by the agent, etc.';
        }
        field(10; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Data"."Company Name" where(ID = field("Task ID")));
        }
    }

    keys
    {
        key(PK; "Task ID", "ID")
        {
            Clustered = true;
        }

        key(TaskId; "Task ID")
        {
        }

        key(TaskIdType; "Task ID", "Type", "ID")
        {
            Unique = false;
            SqlIndex = "Task ID", "Type", "ID";
        }
    }
}