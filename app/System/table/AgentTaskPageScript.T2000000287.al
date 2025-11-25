// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents.Internal;

/// <summary>
/// Stores experimental page script data for agent automation and page interaction capabilities.
/// Provides script content storage for enabling agent automation features during task execution.
/// </summary>
/// <remarks>
/// Temporary table used in experimental agent features for page automation scripting.
/// Part of the experimental agent framework subject to change or removal.
/// Scripts enable agents to interact with pages during automated task processing.
/// </remarks>
table 2000000287 "Agent Task Page Script"
{
    Caption = 'Agent Task Page Script';
    ReplicateData = false;
    Scope = OnPrem;
    TableType = Temporary;

    fields
    {
        /// <summary>
        /// Unique identifier for the page script entry.
        /// </summary>
        field(1; "ID"; Code[10])
        {
            Caption = 'ID';
            DataClassification = SystemMetadata;
        }
        /// <summary>
        /// Script content stored in binary format for agent page automation.
        /// </summary>
        field(2; "Content"; Blob)
        {
            Caption = 'Content';
            DataClassification = CustomerContent;
        }
    }
}
