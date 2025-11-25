// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents.Internal;

using System.Agents;

table 2000000271 "Agent Task Timeline Step Data"
{
    Caption = 'Agent Task Timeline Step Data';
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
        field(2; "ID"; BigInteger)
        {
            AutoIncrement = true;
        }
        field(3; "Title"; Text[100])
        {
            Caption = 'Title';
        }
        field(4; Description; Text[2048])
        {
            ToolTip = 'A description of what happened as part of this timeline step. This is used to provide context to the user.';
        }
        field(5; "Primary Page ID"; Integer)
        {
            ToolTip = 'The page ID of the primary page associated with the timeline step.';
        }
        field(6; "Primary Page Record ID"; RecordId)
        {
            ToolTip = 'The record ID associated with the timeline step.';
        }
        field(7; "Primary Page Summary"; Blob)
        {
            ToolTip = 'The page summary of the primary page associated with the timeline step.';
        }
        field(8; "Primary Page Query"; Blob)
        {
            ToolTip = 'The page query string of the primary page associated with the timeline step.';
        }
        field(9; "First Log Entry ID"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = min("Agent Task Log Entry Data"."ID" where("Task ID" = field("Task ID"), "Timeline Step ID" = field(ID)));
        }
        field(10; "First Log Entry Type"; Enum "Agent Task Log Entry Type")
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Log Entry Data".Type where("Task ID" = field("Task ID"), "ID" = field("First Log Entry ID")));
        }
        field(11; "Last Log Entry ID"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = max("Agent Task Log Entry Data"."ID" where("Task ID" = field("Task ID"), "Timeline Step ID" = field(ID)));
        }
        field(12; "Last Log Entry Type"; Enum "Agent Task Log Entry Type")
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Log Entry Data".Type where("Task ID" = field("Task ID"), "ID" = field("Last Log Entry ID")));
        }
        field(13; "Task Agent User Security ID"; Guid)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Data"."Agent User Security ID" where(ID = field("Task ID")));
        }
        field(14; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Data"."Company Name" where(ID = field("Task ID")));
        }
        field(15; "Task Needs Attention"; Boolean)
        {
            Caption = 'Task Needs Attention';
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Data"."Needs Attention" where(ID = field("Task ID")));
        }
        field(16; Importance; Option)
        {
            Caption = 'Importance';
            OptionCaption = 'Primary,Secondary';
            OptionMembers = Primary,Secondary;
        }
        field(17; "Last User Intervention Request"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = max("Agent Task Log Entry Data"."ID" where("Task ID" = field("Task ID"),
                                                                         "Timeline Step ID" = field(ID),
                                                                         Type = const("Agent Task Log Entry Type"::"User Intervention Request")));
        }
        field(18; "Last User Intervention"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = max("Agent Task Log Entry Data"."ID" where("Task ID" = field("Task ID"),
                                                                         "Timeline Step ID" = field(ID),
                                                                         Type = filter("Agent Task Log Entry Type"::"User Intervention Request" | "Agent Task Log Entry Type"::"User Intervention")));
        }
    }

    keys
    {
        key(PK; "Task ID", "ID")
        {
            Clustered = true;
        }
        key(PrimaryPageRecordId; "Primary Page Record ID")
        {
        }
    }
}