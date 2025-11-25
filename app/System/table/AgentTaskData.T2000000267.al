// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents.Internal;

using System.Agents;
using System.Environment;
using System.Security.AccessControl;

table 2000000267 "Agent Task Data"
{
    Caption = 'Agent Task Data';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;
    Access = Internal;

    fields
    {
        field(1; "ID"; BigInteger)
        {
            Caption = 'ID';
            AutoIncrement = true;
        }
        field(2; "Agent User Security ID"; Guid)
        {
            Caption = 'Agent User Security ID';
            TableRelation = "Agent Data"."User Security ID";
        }
        field(3; "Created By"; Guid)
        {
            Caption = 'Created By';
            TableRelation = User."User Security ID";
        }
        field(4; "Status"; Enum "Agent Task Status")
        {
            Caption = 'Status';
        }
        field(5; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            TableRelation = Company."Name";
        }
        field(6; "Last Step Number"; Integer)
        {
            Caption = 'Last Step Number';
            FieldClass = FlowField;
            CalcFormula = max("Agent Task Step Data"."Step Number" where("Task ID" = field(ID)));
        }
        field(7; "Last Step Timestamp"; DateTime)
        {
            Caption = 'Last Step Timestamp';
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Step Data".SystemCreatedAt where("Task ID" = field(ID), "Step Number" = field("Last Step Number")));
        }
        field(8; "External ID"; Text[2048])
        {
            Caption = 'External ID';
        }
        field(9; "Title"; Text[150])
        {
            Caption = 'Title';
        }
        field(10; "New Input Message Count"; Integer)
        {
            Caption = 'New Input Message Count';
            FieldClass = FlowField;
            CalcFormula = count("Agent Task Message Data" where("Task ID" = field(ID), Type = const(Input), Status = const(" ")));
        }
        field(11; "Instructions Hash"; Text[64])
        {
            Caption = 'Instructions Hash';
            ToolTip = 'The hash of the agent''s instruction when the task was created.';
        }
        field(12; "Created With Curr Instructions"; Boolean)
        {
            Caption = 'Created With Curr Instructions';
            ToolTip = 'Specifies whether the task was created with the same instructions than the current instructions for the agent.';
            FieldClass = FlowField;
            CalcFormula = exist("Agent Data" where("User Security ID" = field("Agent User Security ID"),
                                                   "Instructions Hash" = field("Instructions Hash")));
        }
        field(13; "Agent Metadata Provider"; Enum "Agent Metadata Provider")
        {
            Caption = 'Agent Metadata Provider';
            Tooltip = 'Specifies the provider for the agent metadata.';
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Data"."Agent Metadata Provider" where("User Security ID" = field("Agent User Security ID")));
        }
        field(14; "Needs Attention"; Boolean)
        {
            Caption = 'Needs Attention';
            ToolTip = 'Specifies whether the task needs attention.';
            InitValue = false;
        }
        field(15; "Last Step Type"; Enum "Agent Task Step Type")
        {
            Caption = 'Last Step Type';
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Step Data".Type where("Task ID" = field(ID), "Step Number" = field("Last Step Number")));
        }
    }

    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
        key(AgentUserSecurityID; "Agent User Security ID")
        {
        }
        key(AgentUserSecurityIDStatus; "Agent User Security ID", Status)
        {
        }
        key(StatusCreatedAt; Status, SystemCreatedAt)
        {
        }
        key(ExternalID; "External ID")
        {
        }
    }
}