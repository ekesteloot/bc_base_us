// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

/// <summary>
/// Virtual table that stores detailed information about individual steps in agent task timelines.
/// </summary>
/// <remarks>
/// This table provides granular step-by-step tracking of agent task execution, capturing each
/// significant action, decision point, and user intervention in the task lifecycle. Essential for
/// detailed task monitoring, debugging agent behavior, and providing audit trails.
/// Each step includes contextual information, associated pages, user intervention requests, and
/// outcome details. Used by the agent framework to manage task progression and by monitoring
/// tools to provide detailed execution visibility.
/// </remarks>
table 2000000276 "Agent Task Timeline Step"
{
    Caption = 'Agent Task Timeline Step';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// The unique identifier of the agent task that this timeline step belongs to.
        /// </summary>
        field(1; "Task ID"; BigInteger)
        {
            Caption = 'Task ID';
            Editable = false;
            TableRelation = "Agent Task".ID;
            ToolTip = 'Specifies the unique identifier of the task this timeline step is a part of.';
        }
        /// <summary>
        /// The unique identifier of this timeline step within the task.
        /// </summary>
        field(2; "ID"; BigInteger)
        {
            Caption = 'ID';
            Editable = false;
            ToolTip = 'Specifies the unique identifier for the timeline step.';
        }
        /// <summary>
        /// The title or name of this timeline step for display purposes.
        /// </summary>
        field(3; "Title"; Text[100])
        {
            Caption = 'Title';
            Editable = false;
            ToolTip = 'Specifies the title of the timeline step.';
        }
        /// <summary>
        /// A detailed description of what occurred during this timeline step.
        /// </summary>
        field(4; Description; Text[2048])
        {
            Caption = 'Description';
            Editable = false;
            ToolTip = 'Specifies the description of what happened as part of this timeline step. This is used to provide context to the user.';
        }
        /// <summary>
        /// A summary of the primary page associated with this timeline step.
        /// </summary>
        field(5; "Primary Page Summary"; Blob)
        {
            Caption = 'Primary Page Summary';
            ToolTip = 'Specifies the summary of the primary page associated with the timeline step.';
        }
        /// <summary>
        /// The query string used to access the primary page associated with this timeline step.
        /// </summary>
        field(6; "Primary Page Query"; Blob)
        {
            Caption = 'Primary Page Query';
            ToolTip = 'Specifies the client query string of the primary page associated with the timeline step.';
        }
        /// <summary>
        /// The identifier of the last log entry recorded for this timeline step.
        /// </summary>
        field(7; "Last Log Entry ID"; Integer)
        {
            Caption = 'Last Log Entry ID';
            ToolTip = 'Specifies the ID of the last log entry in the timeline step.';
            Editable = false;
        }
        /// <summary>
        /// The type of the last log entry recorded for this timeline step.
        /// </summary>
        field(8; "Last Log Entry Type"; Enum "Agent Task Log Entry Type")
        {
            Caption = 'Last Log Entry Type';
            ToolTip = 'Specifies the type of the last log entry in the timeline step.';
            Editable = false;
        }
        /// <summary>
        /// The temporal category of this timeline step (Past, Present, or Future).
        /// </summary>
        field(9; Category; Option)
        {
            Caption = 'Category';
            ToolTip = 'Specifies the timeline step category.';
            OptionCaption = 'Past,Present,Future';
            OptionMembers = Past,Present,Future;
            Editable = false;
        }
        /// <summary>
        /// The specific type of action or event that this timeline step represents.
        /// </summary>
        field(10; Type; Enum "Agent Task Timeline Step Type")
        {
            Caption = 'Type';
            ToolTip = 'Specifies the timeline step type.';
            Editable = false;
        }
        /// <summary>
        /// The type of user intervention requested when this step requires user input.
        /// </summary>
        field(11; "User Intervention Request Type"; Option)
        {
            Caption = 'User Intervention Request Type';
            ToolTip = 'Specifies the user intervention request type when the timeline step is a user intervention request.';
            OptionCaption = ',Review Message,Assistance,Review Record,Resume Task,Retry';
            OptionMembers = " ",ReviewMessage,Assistance,ReviewRecord,ResumeTask,Retry;
            Editable = false;
        }
        /// <summary>
        /// Additional annotations or metadata associated with this timeline step.
        /// </summary>
        field(12; Annotations; Blob)
        {
            Caption = 'Annotations';
            ToolTip = 'Specifies the annotations for the timeline step, if any.';
        }
        /// <summary>
        /// The page ID of the primary page associated with this timeline step.
        /// </summary>
        field(13; "Primary Page ID"; Integer)
        {
            Caption = 'Primary Page ID';
            ToolTip = 'Specifies the page ID of the primary page associated with the timeline step.';
        }
        /// <summary>
        /// The record ID of the specific record associated with this timeline step.
        /// </summary>
        field(14; "Primary Page Record ID"; RecordId)
        {
            Caption = 'Primary Page Record ID';
            ToolTip = 'Specifies the record ID associated with the timeline step.';
        }
        /// <summary>
        /// The importance level of this timeline step (Primary or Secondary).
        /// </summary>
        field(15; Importance; Option)
        {
            Caption = 'Importance';
            ToolTip = 'Specifies the category of the timeline step.';
            OptionCaption = 'Primary,Secondary';
            OptionMembers = Primary,Secondary;
        }
        /// <summary>
        /// The identifier of the last user intervention step associated with this timeline step.
        /// </summary>
        field(16; "Last User Intervention ID"; Integer)
        {
            Caption = 'Last User Intervention Step ID';
            ToolTip = 'Specifies the ID of the log entry representing the last user intervention (request) step in the timeline step.';
            Editable = false;
        }
        /// <summary>
        /// Suggestions that can be provided to users for certain intervention requests.
        /// </summary>
        field(17; "Suggestions"; Blob)
        {
            Caption = 'Suggestions';
            ToolTip = 'Specifies the suggestions that can be used to provide input for certain user intervention requests.';
        }
        /// <summary>
        /// Detailed information about the last user intervention in this timeline step.
        /// </summary>
        field(18; "Last User Intervention Details"; Blob)
        {
            Caption = 'Last User Intervention Details';
            ToolTip = 'Specifies the details of the last user intervention in the timeline step.';
        }
    }

    keys
    {
        key(PK; "Task ID", "ID")
        {
            Clustered = true;
        }
        key(TaskID; "Task ID")
        {
        }
        key(PrimaryPageRecordId; "Primary Page Record ID")
        {
        }
    }
}