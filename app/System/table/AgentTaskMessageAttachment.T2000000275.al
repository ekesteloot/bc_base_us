// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

/// <summary>
/// Virtual table that manages the relationship between agent task messages and their file attachments.
/// </summary>
/// <remarks>
/// This table provides the linkage between messages and files in agent task conversations, enabling
/// messages to have multiple file attachments and files to be referenced by multiple messages.
/// Essential for handling rich communication scenarios where files are shared as part of agent interactions.
/// The table maintains referential integrity between tasks, messages, and files through table relations.
/// Scoped to OnPrem and not replicated for security and performance considerations.
/// </remarks>
table 2000000275 "Agent Task Message Attachment"
{
    Caption = 'Agent Task Message Attachment';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// The unique identifier of the agent task that this attachment relationship belongs to.
        /// </summary>
        field(1; "Task ID"; BigInteger)
        {
            TableRelation = "Agent Task".ID;
            Caption = 'Task ID';
            Editable = false;
            ToolTip = 'Specifies the unique identifier of the task this message attachment was created a part of.';
        }
        /// <summary>
        /// The unique identifier of the message that has the file attached to it.
        /// </summary>
        field(2; "Message ID"; Guid)
        {
            TableRelation = "Agent Task Message".ID Where("Task ID" = Field("Task ID"));
            Caption = 'Message ID';
            Editable = false;
            ToolTip = 'Specifies the unique identifier of the task message the file is attached to.';
        }
        /// <summary>
        /// The unique identifier of the file that is attached to the message.
        /// </summary>
        field(3; "File ID"; BigInteger)
        {
            TableRelation = "Agent Task File"."ID" Where("Task ID" = Field("Task ID"));
            Caption = 'File ID';
            Editable = false;
            ToolTip = 'Specifies the unique identifier of the file that is attached to the task message.';
        }
        /// <summary>
        /// The text content of the message attachment.
        /// </summary>
        field(4; "Text Content"; Blob)
        {
            Caption = 'Text Content';
            ToolTip = 'Specifies the text content of the message attachment.';
        }
        /// <summary>
        /// Whether the attachment is ignored.
        /// </summary>
        field(5; "Ignored"; Boolean)
        {
            Caption = 'Ignored';
            ToolTip = 'Specifies whether the message attachment is ignored.';
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