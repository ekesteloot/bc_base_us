// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

using System.Security.AccessControl;

table 2000000263 "Agent Task Message"
{
    Caption = 'Agent Task Message';
    DataPerCompany = false;
    Scope = OnPrem; // TODO(agent) - This should change to Cloud when ready to expose agents.

    fields
    {
        field(1; "Task ID"; BigInteger)
        {
            Caption = 'Task ID';
            ToolTip = 'Specifies the ID of the task the message belongs to.';
            Editable = false;
            TableRelation = "Agent Task".ID;
        }
        field(2; "ID"; Guid)
        {
            Caption = 'ID';
            ToolTip = 'Specifies the unique identifier for the message.';
            Editable = false;
        }
        field(3; "Type"; Option)
        {
            Caption = 'Type';
            ToolTip = 'Specifies the message type.';
            Editable = false;
            OptionCaption = 'Input,Output';
            OptionMembers = Input,Output;
        }
        field(4; "Status"; Option)
        {
            Caption = 'Status';
            ToolTip = 'Specifies the message status.';
            OptionCaption = ',Draft,Sent,Reviewed,Rejected,Discarded';
            OptionMembers = " ",Draft,Sent,Reviewed,Rejected,Discarded;
        }
        field(5; Content; Blob)
        {
            Caption = 'Content';
            ToolTip = 'Specifies the message content.';
        }
        field(6; "Created By Full Name"; Text[80])
        {
            Caption = 'Created By Full Name';
            Tooltip = 'Specifies the full name of the user that created the message.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("User"."Full Name" where("User Security ID" = field(SystemCreatedBy)));
        }
        field(7; "External ID"; Text[2048])
        {
            Caption = 'External ID';
            Tooltip = 'Specifies the external identifier related to the agent task message, such as an Outlook or Teams message identifier.';
        }
        field(8; "Input Message ID"; Guid)
        {
            Caption = 'Input Message ID';
            ToolTip = 'Specifies the unique identifier for the message that this message answers to. Applicable only for messages of type Output.';
            TableRelation = "Agent Task Message".ID;
        }
        field(9; "Status Reason"; Text[250])
        {
            Caption = 'Status Reason';
            ToolTip = 'Specifies the reason for the message status, if available.';
        }
        field(10; From; Text[250])
        {
            Caption = 'From';
            ToolTip = 'Specifies the sender of the message when it is an input message.';
        }
        field(11; "Properties"; Blob)
        {
            Caption = 'Properties';
            ToolTip = 'Specifies custom properties that can be set on the message.';
        }
        field(12; "Requires Review"; Boolean)
        {
            InitValue = true;
            Caption = 'Requires Review';
            ToolTip = 'Specifies whether the message requires to be reviewed by a user. Currently only supported for input messages.';
        }
        field(13; "Agent User Security ID"; Guid)
        {
            Caption = 'Agent User Security ID';
            Editable = false;
            TableRelation = Agent."User Security ID";
            Tooltip = 'Specifies the unique identifier for the agent user.';
        }
    }

    keys
    {
        key(PK; "Task ID", ID)
        {
            Clustered = true;
        }
    }
}