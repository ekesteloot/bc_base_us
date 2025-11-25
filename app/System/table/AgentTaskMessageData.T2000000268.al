// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents.Internal;

table 2000000268 "Agent Task Message Data"
{
    Caption = 'Agent Task Message Data';
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
        field(3; "Type"; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Input,Output';
            OptionMembers = Input,Output;
        }
        field(4; "Status"; Option)
        {
            Caption = 'Status';
            OptionCaption = ',Draft,Sent,Reviewed,Rejected,Discarded';
            OptionMembers = " ",Draft,Sent,Reviewed,Rejected,Discarded;
        }
        field(5; Content; Blob)
        {
        }
        field(6; "External ID"; Text[2048])
        {
            Caption = 'External ID';
        }
        field(7; "Input Message System ID"; Guid)
        {
            Caption = 'Input Message System ID';
            TableRelation = "Agent Task Message Data".SystemId;
        }
        field(8; "Status Reason"; Text[250])
        {
            Caption = 'Status Reason';
        }
        field(9; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Data"."Company Name" where(ID = field("Task ID")));
        }
        field(10; "Task Agent User Security ID"; Guid)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Data"."Agent User Security ID" where(ID = field("Task ID")));
        }
        field(11; From; Text[250])
        {
            Caption = 'From';
            ToolTip = 'Specifies the sender of the message when it is an input message.';
        }
        field(12; "Properties"; Blob)
        {
            Caption = 'Properties';
            ToolTip = 'Specifies custom properties that can be set on the message.';
        }
#pragma warning disable AS0132 // Temporary change while fixing the validation in official builds.
        field(13; "Requires Review"; Boolean)
        {
            InitValue = true;
            Caption = 'Requires Review';
            ToolTip = 'Specifies whether the message requires to be reviewed by a user. Currently only supported for input messages.';
        }
#pragma warning restore AS0132
    }

    keys
    {
        key(PK; "Task ID", ID)
        {
            Clustered = true;
        }
        key(TaskIDTimestamp; "Task ID", SystemCreatedAt)
        {
        }
        key(TaskIDExternalID; "Task ID", "External ID")
        {
        }
    }
}