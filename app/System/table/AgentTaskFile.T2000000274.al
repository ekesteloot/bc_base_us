// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

table 2000000274 "Agent Task File"
{
    Caption = 'Agent Task File';
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
            ToolTip = 'Specifies the unique identifier of the task this file was created a part of.';
        }
        field(2; "ID"; BigInteger)
        {
            Caption = 'ID';
            Editable = false;
            Tooltip = 'Specifies the unique identifier of the file.';
        }
        field(3; "File Name"; Text[250])
        {
            Caption = 'File Name';
            Editable = false;
            Tooltip = 'Specifies the original file name.';
        }
        field(4; "File MIME Type"; Text[100])
        {
            Caption = 'File MIME Type';
            Editable = false;
            Tooltip = 'Specifies the MIME type of the file.';
        }
        field(5; "Content"; Blob)
        {
            Caption = 'Content';
            Tooltip = 'Specifies the content of the file.';
        }
    }

    keys
    {
        key(PK; "Task ID", "ID")
        {
            Clustered = true;
        }
    }
}