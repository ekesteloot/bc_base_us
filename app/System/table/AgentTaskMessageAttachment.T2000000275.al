// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

using System.Environment;
using System.Security.AccessControl;

table 2000000275 "Agent Task Message Attachment"
{
    Caption = 'Agent Task Message Attachment';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        field(1; "Task ID"; BigInteger)
        {
            TableRelation = "Agent Task".ID;
            Caption = 'Task ID';
            Editable = false;
            ToolTip = 'Specifies the unique identifier of the task this message attachment was created a part of.';
        }
        field(2; "Message ID"; Guid)
        {
            TableRelation = "Agent Task Message".ID Where("Task ID" = Field("Task ID"));
            Caption = 'Message ID';
            Editable = false;
            ToolTip = 'Specifies the unique identifier of the task message the file is attached to.';
        }
        field(3; "File ID"; BigInteger)
        {
            TableRelation = "Agent Task File"."ID" Where("Task ID" = Field("Task ID"));
            Caption = 'File ID';
            Editable = false;
            ToolTip = 'Specifies the unique identifier of the file that is attached to the task message.';
        }
    }

    keys
    {
        key(PK; "Task ID", "Message ID", "File ID")
        {
            Clustered = true;
        }
        key(TaskIdMessageId; "Task ID", "Message ID")
        {
            Unique = false;
        }
    }
}