// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

using System.Security.AccessControl;

table 2000000277 "Agent Task Timeline Step Det."
{
    Caption = 'Agent Task Timeline Step Detail';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        field(1; "Task ID"; BigInteger)
        {
            Caption = 'Task ID';
            ToolTip = 'Specifies the unique identifier of the task the timeline step is a part of.';
            Editable = false;
            TableRelation = "Agent Task".ID;
        }
        field(2; "ID"; Integer)
        {
            Caption = 'ID';
            ToolTip = 'Specifies the unique identifier for the timeline step detail entry.';
            Editable = false;
        }
        field(3; "Timeline Step ID"; BigInteger)
        {
            Caption = 'Timeline Step ID';
            ToolTip = 'Specifies the ID of the timeline step this detail entry is a part of.';
        }
        field(4; "User Security ID"; Guid)
        {
            Caption = 'User Security ID';
            ToolTip = 'Specifies the security ID of the user that was involved in performing the step.';
            Editable = false;
            TableRelation = User."User Security ID";
        }
        field(5; "Type"; Enum "Agent Task Log Entry Type")
        {
            Caption = 'Type';
            ToolTip = 'Specifies the type of log entry associated with the detail entry.';
            Editable = false;
        }
        field(6; "Client Context"; Blob)
        {
            Caption = 'Client Context';
            ToolTip = 'Specifies the client context.';
        }
    }

    keys
    {
        key(PK; "Task ID", "ID")
        {
            Clustered = true;
        }
        key(TimelineStepID; "Task ID", "Timeline Step ID")
        {
        }
    }
}