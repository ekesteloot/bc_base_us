// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents.Internal;

table 2000000270 "Agent Task User Int. Data"
{
    Caption = 'Agent Task User Intervention Data';
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
        field(2; "Memory Entry ID"; Integer)
        {
            ToolTip = 'Specifies the memory entry this user intervention is associated with.';
            TableRelation = "Agent Task Memory Entry Data"."ID";
        }
        field(3; "Is Pending"; Boolean)
        {
            InitValue = true;
        }
        field(4; "Intervention Request Type"; Integer)
        {
        }
        field(5; "Related Record ID"; RecordId)
        {
            ToolTip = 'Specifies the optional record related to this user intervention.';
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Memory Entry Data"."Related Record ID" where("Task ID" = field("Task ID"), "ID" = field("Memory Entry ID")));
        }
    }

    keys
    {
        key(PK; "Task ID", "Memory Entry ID")
        {
            Clustered = true;
        }
        key(TaskID; "Task ID")
        {
        }
    }
}