// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

table 2000000279 "Agent Task User Int Suggestion"
{
    Caption = 'Agent Task User Intervention Suggestion';
    ReplicateData = false;
    Scope = OnPrem; // TODO(agent) - This should change to Cloud when ready to expose agents.
    TableType = Temporary;

    fields
    {
        field(1; "Summary"; Text[100])
        {
            Caption = 'Summary';
            Tooltip = 'A summary of the suggestion that will be displayed to users.';
        }
        field(2; "Instructions"; Text[1024])
        {
            Caption = 'Instructions';
            Tooltip = 'The instructions that will be provided to the agent if this suggestion is used.';
        }
        field(3; "Description"; Text[1024])
        {
            Caption = 'Description';
            Tooltip = 'The description for this suggestion that is used to determine situations in which it may be applicable.';
        }
    }

    keys
    {
        key(PK; "Summary")
        {
            Clustered = true;
        }
    }
}
