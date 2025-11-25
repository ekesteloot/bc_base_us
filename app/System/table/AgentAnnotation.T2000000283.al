// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

table 2000000283 "Agent Annotation"
{
    Caption = 'Agent Annotation';
    ReplicateData = false;
    Scope = OnPrem; // TODO(agent) - This should change to Cloud when ready to expose agents.
    TableType = Temporary;

    fields
    {
        field(1; "Code"; Text[20])
        {
            Caption = 'Code';
            Tooltip = 'The code defining the type of annotation.';
        }
        field(2; "Message"; Text[2048])
        {
            Caption = 'Message';
            Tooltip = 'The message of the annotation.';
        }
        field(3; "Details"; Text[2048])
        {
            Caption = 'Details';
            Tooltip = 'The details of the annotation.';
        }
        field(4; "Severity"; Option)
        {
            Caption = 'Severity';
            OptionCaption = 'Info,Warning,Error';
            OptionMembers = Info,Warning,Error;
            Tooltip = 'The severity of the annotation.';
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
