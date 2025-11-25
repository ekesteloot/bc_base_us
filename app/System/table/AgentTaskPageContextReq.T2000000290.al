// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

table 2000000290 "Agent Task Page Context Req."
{
    Caption = 'Agent Task Page Context Request';
    ReplicateData = false;
    Scope = OnPrem; // TODO(agent) - This should change to Cloud when ready to expose agents.
    TableType = Temporary;

    fields
    {
        field(1; "Agent User ID"; Guid)
        {
            Caption = 'Agent User ID';
        }
        field(2; "Task ID"; BigInteger)
        {
            Caption = 'Task ID';
        }
        field(3; "Page ID"; Integer)
        {
            Caption = 'Page ID';
            ToolTip = 'Specifies the ID of the page the context request is intended for.';
        }
        field(4; "Record ID"; RecordId)
        {
            Caption = 'Record ID';
            Tooltip = 'Specifies the ID of the record the context request is intended for.';
        }
    }

    keys
    {
        key(PK; "Agent User ID", "Task ID", "Page ID", "Record ID")
        {
            Clustered = true;
        }
    }
}
