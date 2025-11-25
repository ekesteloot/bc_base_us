// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents.Internal;

using System.Agents;
using System.Security.AccessControl;

table 2000000281 "Agent Task Log Entry Data"
{
    Caption = 'Agent Task Log Entry Data';
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
        field(2; "ID"; Integer)
        {
        }
        field(3; "User Security ID"; Guid)
        {
            TableRelation = User."User Security ID";
        }
        field(4; "Type"; Enum "Agent Task Log Entry Type")
        {
        }
        field(5; "Details"; Blob)
        {
        }
        field(6; "Description"; Text[2048])
        {
        }
        field(7; "Level"; Option)
        {
            OptionCaption = 'Information,Warning,Error';
            OptionMembers = Information,Warning,Error;
        }
        field(8; "Page Caption"; Text[150])
        {
        }
        field(9; "Client Context"; Blob)
        {
        }
        field(10; "Memory Entry ID"; Integer)
        {
            ToolTip = 'Specifies the memory entry this log entry is associated with.';
            TableRelation = "Agent Task Memory Entry Data"."ID";
            ValidateTableRelation = false;
        }
        field(11; "Timeline Step ID"; BigInteger)
        {
            ToolTip = 'Specifies the timeline step this log entry is associated with.';
            TableRelation = "Agent Task Timeline Step Data".ID;
            ValidateTableRelation = false;
        }
        field(12; "Task Agent User Security ID"; Guid)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Data"."Agent User Security ID" where(ID = field("Task ID")));
        }
        field(13; "Company Name"; Text[30])
        {
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
        key(TaskIdMemoryEntryId; "Task ID", "Memory Entry ID")
        {
        }
        key(TimelineStepID; "Task ID", "Timeline Step ID", "ID")
        {
        }
    }
}