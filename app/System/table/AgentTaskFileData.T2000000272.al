// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents.Internal;

/// <summary>
/// Stores file attachments and content associated with agent tasks, enabling agents to work with files and documents.
/// </summary>
/// <remarks>
/// This table manages file data that agents can access, process, or generate during task execution.
/// Files are linked to specific tasks and memory entries, allowing agents to maintain context about
/// file operations and content. Stores file metadata including name and MIME type along with the
/// actual file content as BLOB data. Used by the agent framework to provide file handling capabilities
/// and maintain file associations with agent tasks and memory entries.
/// </remarks>
table 2000000272 "Agent Task File Data"
{
    Caption = 'Agent Task File Data';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;
    Access = Internal;

    fields
    {
        /// <summary>
        /// Identifier of the agent task this file data belongs to.
        /// </summary>
        field(1; "Task ID"; BigInteger)
        {
            TableRelation = "Agent Task Data".ID;
        }
        /// <summary>
        /// Unique auto-incrementing identifier for the file within the task.
        /// </summary>
        field(2; "ID"; BigInteger)
        {
            AutoIncrement = true;
        }
        /// <summary>
        /// ID of the memory entry this file is associated with for context linking.
        /// </summary>
        field(3; "Memory Entry ID"; Integer)
        {
            TableRelation = "Agent Task Memory Entry Data"."ID" where("Task ID" = field("Task ID"));
        }
        /// <summary>
        /// Name of the file including extension.
        /// </summary>
        field(4; "File Name"; Text[250])
        {
        }
        /// <summary>
        /// MIME type of the file content for proper handling and processing.
        /// </summary>
        field(5; "File MIME Type"; Text[100])
        {
        }
        /// <summary>
        /// Binary content of the file stored as BLOB.
        /// </summary>
        field(6; "Content"; Blob)
        {
        }
        /// <summary>
        /// Company name context for the task this file belongs to, calculated from the task data.
        /// </summary>
        field(7; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Data"."Company Name" where(ID = field("Task ID")));
        }
        /// <summary>
        /// Security ID of the agent user for the task this file belongs to, calculated from the task data.
        /// </summary>
        field(8; "Task Agent User Security ID"; Guid)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Data"."Agent User Security ID" where(ID = field("Task ID")));
        }
    }

    keys
    {
        key(PK; "Task ID", "ID")
        {
            Clustered = true;
        }
        key(TaskIdMemoryEntryId; "Task ID", "Memory Entry ID")
        {
        }
    }
}