// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

table 2000000276 "Agent Task Timeline Entry"
{
    Caption = 'Agent Task Timeline Entry';
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
            ToolTip = 'Specifies the unique identifier of the task this timeline entry is a part of.';
        }
        field(2; "ID"; BigInteger)
        {
            Caption = 'Entry ID';
            Editable = false;
            ToolTip = 'Specifies the unique identifier for the timeline entry.';
        }
        field(3; "Title"; Text[100])
        {
            Caption = 'Title';
            Editable = false;
            ToolTip = 'Specifies the title of the timeline entry.';
        }
        field(4; Description; Text[2048])
        {
            Caption = 'Description';
            Editable = false;
            ToolTip = 'Specifies the description of what happened as part of this timeline entry. This is used to provide context to the user.';
        }
        field(5; "Primary Page Summary"; Blob)
        {
            Caption = 'Primary Page Summary';
            ToolTip = 'Specifies the summary of the primary page associated with the timeline entry.';
        }
        field(6; "Primary Page Query"; Blob)
        {
            Caption = 'Primary Page Query';
            ToolTip = 'Specifies the client query string of the primary page associated with the timeline entry.';
        }
        field(7; "Last Step Number"; Integer)
        {
            Caption = 'Last Step Number';
            ToolTip = 'Specifies the step number of the last step in the timeline entry.';
            Editable = false;
        }
        field(8; "Last Step Type"; Enum "Agent Task Step Type")
        {
            Caption = 'Last Step Type';
            ToolTip = 'Specifies the step type of the last step in the timeline entry.';
            Editable = false;
        }
        field(9; Category; Option)
        {
            Caption = 'Category';
            ToolTip = 'Specifies the timeline entry category.';
            OptionCaption = 'Past,Present,Future';
            OptionMembers = Past,Present,Future;
            Editable = false;
        }
        field(10; Type; Option)
        {
            Caption = 'Type';
            ToolTip = 'Specifies the timeline entry type.';
            OptionCaption = 'Default,Message,UserInterventionRequest';
            OptionMembers = Default,Message,UserInterventionRequest;
            Editable = false;
        }
        field(11; "User Intervention Request Type"; Option)
        {
            Caption = 'User Intervention Request Type';
            ToolTip = 'Specifies the user intervention request type when the timeline entry is pending user intervention.';
            OptionCaption = ',Review Message,Assistance,Review Record';
            OptionMembers = " ",ReviewMessage,Assistance,ReviewRecord;
            Editable = false;
        }
        field(12; Annotation; Blob)
        {
            Caption = 'Annotation';
            ToolTip = 'Specifies the annotation for the timeline entry, if any.';
        }
        field(13; "Primary Page ID"; Integer)
        {
            Caption = 'Primary Page ID';
            ToolTip = 'Specifies the page ID of the primary page associated with the timeline entry.';
        }
        field(14; "Primary Page Record ID"; RecordId)
        {
            Caption = 'Primary Page Record ID';
            ToolTip = 'Specifies the record ID associated with the timeline entry.';
        }
        field(15; Importance; Option)
        {
            Caption = 'Importance';
            ToolTip = 'Specifies the category of the timeline entry.';
            OptionCaption = 'Primary,Secondary';
            OptionMembers = Primary,Secondary;
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