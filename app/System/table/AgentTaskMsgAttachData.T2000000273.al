// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents.Internal;

/// <summary>
/// Stores attachment data linking agent task messages to their associated files.
/// </summary>
/// <remarks>
/// This internal table manages the relationship between agent task messages and their file attachments.
/// It provides the linking mechanism for associating files with specific messages within the agent task execution framework.
/// Essential for maintaining file attachment relationships in agent conversations and task documentation.
/// </remarks>
table 2000000273 "Agent Task Msg Attach Data"
{
    Caption = 'Agent Task Message Attachment Data';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;
    Access = Internal;

    fields
    {
        /// <summary>
        /// The unique identifier of the agent task that owns this message attachment.
        /// </summary>
        field(1; "Task ID"; BigInteger)
        {
            TableRelation = "Agent Task Data".ID;
        }
        /// <summary>
        /// The unique identifier of the message that this attachment belongs to.
        /// </summary>
        field(2; "Message ID"; BigInteger)
        {
            TableRelation = "Agent Task Message Data".ID Where("Task ID" = Field("Task ID"));
        }
        /// <summary>
        /// The unique identifier of the file that is attached to the message.
        /// </summary>
        field(3; "File ID"; BigInteger)
        {
            TableRelation = "Agent Task File Data"."ID" Where("Task ID" = Field("Task ID"));
        }
        /// <summary>
        /// The system ID of the message for additional referencing.
        /// </summary>
        field(4; "Message System ID"; Guid)
        {
            CalcFormula = Lookup("Agent Task Message Data".SystemId Where("Task ID" = Field("Task ID"), "ID" = Field("Message ID")));
            FieldClass = FlowField;
        }
        /// <summary>
        /// The company name where the parent agent task is being executed.
        /// </summary>
        field(5; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Data"."Company Name" where(ID = field("Task ID")));
        }
        /// <summary>
        /// The user security ID of the agent associated with the parent task.
        /// </summary>
        field(6; "Task Agent User Security ID"; Guid)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Data"."Agent User Security ID" where(ID = field("Task ID")));
        }
        /// <summary>
        /// The text content of the message attachment.
        /// </summary>
        field(7; "Text Content"; Blob)
        {
            Caption = 'Text Content';
            ToolTip = 'Specifies the text content of the message attachment.';
        }
        /// <summary>
        /// Custom properties for the message attachment stored as BLOB for extensibility.
        /// </summary>
        field(8; "Properties"; Blob)
        {
            Caption = 'Properties';
            ToolTip = 'Specifies custom properties that can be set on the message attachment.';
        }
        /// <summary>
        /// The file name of the attached file.
        /// </summary>
        field(9; "File Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task File Data"."File Name" where("Task ID" = field("Task ID"), "ID" = field("File ID")));
        }
        /// <summary>
        /// Whether the attachment is ignored.
        /// </summary>
        field(10; "Ignored"; Boolean)
        {
            Caption = 'Ignored';
            ToolTip = 'Specifies whether the message attachment is ignored.';
        }
        /// <summary>
        /// The type of message the attachment belongs to.
        /// </summary>
        field(11; "Message Type"; Option)
        {
            OptionCaption = 'Input,Output';
            OptionMembers = Input,Output;
            CalcFormula = Lookup("Agent Task Message Data".Type Where("Task ID" = Field("Task ID"), "ID" = Field("Message ID")));
            FieldClass = FlowField;
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