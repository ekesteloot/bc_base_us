// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents.Internal;

table 2000000272 "Agent Task File Data"
{
    Caption = 'Agent Task File Data';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;
    Access = Internal;

    fields
    {
        field(1; "Task ID"; BigInteger)
        {
            TableRelation = "Agent Task Data".ID;
        }
        field(2; "ID"; BigInteger)
        {
            AutoIncrement = true;
        }
        field(3; "Step Number"; Integer)
        {
            TableRelation = "Agent Task Step Data"."Step Number" Where("Task ID" = Field("Task ID"));
        }
        field(4; "File Name"; Text[250])
        {
        }
        field(5; "File MIME Type"; Text[100])
        {
        }
        field(6; "Content"; Blob)
        {
        }
        field(7; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Data"."Company Name" where(ID = field("Task ID")));
        }
        field(8; "Task Agent User Security ID"; Guid)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Data"."Agent User Security ID" where(ID = field("Task ID")));
        }
    }

    keys
    {
        key(PK; "Task ID", "ID")
        {
            Clustered = true;
        }
        key(TaskIdStepNumber; "Task ID", "Step Number")
        {
        }
    }
}