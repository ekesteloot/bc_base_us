// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

table 2000000276 "Agent Task Timeline Step"
{
    Caption = 'Agent Task Timeline Step';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        field(1; "Task ID"; BigInteger)
        {
            Caption = 'Task ID';
            Editable = false;
            TableRelation = "Agent Task".ID;
            ToolTip = 'Specifies the unique identifier of the task this timeline step is a part of.';
        }
        field(2; "ID"; BigInteger)
        {
            Caption = 'ID';
            Editable = false;
            ToolTip = 'Specifies the unique identifier for the timeline step.';
        }
        field(3; "Title"; Text[100])
        {
            Caption = 'Title';
            Editable = false;
            ToolTip = 'Specifies the title of the timeline step.';
        }
        field(4; Description; Text[2048])
        {
            Caption = 'Description';
            Editable = false;
            ToolTip = 'Specifies the description of what happened as part of this timeline step. This is used to provide context to the user.';
        }
        field(5; "Primary Page Summary"; Blob)
        {
            Caption = 'Primary Page Summary';
            ToolTip = 'Specifies the summary of the primary page associated with the timeline step.';
        }
        field(6; "Primary Page Query"; Blob)
        {
            Caption = 'Primary Page Query';
            ToolTip = 'Specifies the client query string of the primary page associated with the timeline step.';
        }
        field(7; "Last Log Entry ID"; Integer)
        {
            Caption = 'Last Log Entry ID';
            ToolTip = 'Specifies the ID of the last log entry in the timeline step.';
            Editable = false;
        }
        field(8; "Last Log Entry Type"; Enum "Agent Task Log Entry Type")
        {
            Caption = 'Last Log Entry Type';
            ToolTip = 'Specifies the type of the last log entry in the timeline step.';
            Editable = false;
        }
        field(9; Category; Option)
        {
            Caption = 'Category';
            ToolTip = 'Specifies the timeline step category.';
            OptionCaption = 'Past,Present,Future';
            OptionMembers = Past,Present,Future;
            Editable = false;
        }
        field(10; Type; Enum "Agent Task Timeline Step Type")
        {
            Caption = 'Type';
            ToolTip = 'Specifies the timeline step type.';
            Editable = false;
        }
        field(11; "User Intervention Request Type"; Option)
        {
            Caption = 'User Intervention Request Type';
            ToolTip = 'Specifies the user intervention request type when the timeline step is a user intervention request.';
            OptionCaption = ',Review Message,Assistance,Review Record,Resume Task,Retry';
            OptionMembers = " ",ReviewMessage,Assistance,ReviewRecord,ResumeTask,Retry;
            Editable = false;
        }
        field(12; Annotations; Blob)
        {
            Caption = 'Annotations';
            ToolTip = 'Specifies the annotations for the timeline step, if any.';
        }
        field(13; "Primary Page ID"; Integer)
        {
            Caption = 'Primary Page ID';
            ToolTip = 'Specifies the page ID of the primary page associated with the timeline step.';
        }
        field(14; "Primary Page Record ID"; RecordId)
        {
            Caption = 'Primary Page Record ID';
            ToolTip = 'Specifies the record ID associated with the timeline step.';
        }
        field(15; Importance; Option)
        {
            Caption = 'Importance';
            ToolTip = 'Specifies the category of the timeline step.';
            OptionCaption = 'Primary,Secondary';
            OptionMembers = Primary,Secondary;
        }
        field(16; "Last User Intervention ID"; Integer)
        {
            Caption = 'Last User Intervention Step ID';
            ToolTip = 'Specifies the ID of the log entry representing the last user intervention (request) step in the timeline step.';
            Editable = false;
        }
        field(17; "Suggestions"; Blob)
        {
            Caption = 'Suggestions';
            ToolTip = 'Specifies the suggestions that can be used to provide input for certain user intervention requests.';
        }
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