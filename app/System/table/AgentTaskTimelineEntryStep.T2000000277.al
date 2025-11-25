// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

using System.Security.AccessControl;

table 2000000277 "Agent Task Timeline Entry Step"
{
    Caption = 'Agent Task Timeline Entry Step';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

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
        field(3; "Timeline Entry ID"; BigInteger)
        {
            Caption = 'Timeline Entry ID';
            ToolTip = 'Specifies the ID of the timeline entry this step is a part of.';
        }
        field(4; "User Security ID"; Guid)
        {
            Caption = 'User Security ID';
            ToolTip = 'Specifies the security ID of the user that was involved in performing the step.';
            Editable = false;
            TableRelation = User."User Security ID";
        }
        field(5; "Type"; Enum "Agent Task Step Type")
        {
            Caption = 'Type';
            ToolTip = 'Specifies the type of step.';
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
        key(PK; "Task ID", "Step Number")
        {
            Clustered = true;
        }
        key(TimelineEntryID; "Task ID", "Timeline Entry ID")
        {
        }
    }
}