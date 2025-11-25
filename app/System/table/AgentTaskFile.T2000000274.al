// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

/// <summary>
/// Virtual table that stores files associated with agent tasks.
/// </summary>
/// <remarks>
/// This table provides storage and access to files that are created, processed, or attached to agent tasks.
/// Essential for agents that work with file-based operations, document processing, or data exchange scenarios.
/// Files are stored with their original metadata including name and MIME type for proper handling and retrieval.
/// The table is scoped to OnPrem and not replicated, ensuring secure local storage of task-related files.
/// </remarks>
table 2000000274 "Agent Task File"
{
    Caption = 'Agent Task File';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// The unique identifier of the agent task that this file belongs to.
        /// </summary>
        field(1; "Task ID"; BigInteger)
        {
            TableRelation = "Agent Task".ID;
            Caption = 'Task ID';
            Editable = false;
            ToolTip = 'Specifies the unique identifier of the task this file was created a part of.';
        }
        /// <summary>
        /// The unique identifier of the file within the task context.
        /// </summary>
        field(2; "ID"; BigInteger)
        {
            Caption = 'ID';
            Editable = false;
            Tooltip = 'Specifies the unique identifier of the file.';
        }
        /// <summary>
        /// The original name of the file including its extension.
        /// </summary>
        field(3; "File Name"; Text[250])
        {
            Caption = 'File Name';
            Editable = false;
            Tooltip = 'Specifies the original file name.';
        }
        /// <summary>
        /// The MIME type of the file for proper content type identification and handling.
        /// </summary>
        field(4; "File MIME Type"; Text[100])
        {
            Caption = 'File MIME Type';
            Editable = false;
            Tooltip = 'Specifies the MIME type of the file.';
        }
        /// <summary>
        /// The binary content of the file stored as a BLOB.
        /// </summary>
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