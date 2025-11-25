// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Text;

/// <summary>
/// Stores extracted and processed text content from business entities for search, analysis, and AI processing scenarios.
/// </summary>
/// <remarks>
/// This table maintains text representations of business data extracted from various source tables and records.
/// Each entry contains both preview text for quick access and full text content stored as BLOB for comprehensive
/// analysis. Supports different scenarios for text processing such as search indexing, AI analysis, or content
/// extraction. Used by text processing frameworks to provide searchable content and enable advanced text-based
/// functionality across Business Central entities.
/// </remarks>
table 2000000132 "Entity Text"
{
    ReplicateData = false;

    fields
    {
        /// <summary>
        /// Name of the company where the source entity belongs.
        /// </summary>
        field(1; Company; Text[30])
        {
            DataClassification = SystemMetadata;
            TableRelation = System.Environment.Company.Name;
        }
        /// <summary>
        /// Table ID of the source entity from which the text was extracted.
        /// </summary>
        field(2; "Source Table Id"; Integer)
        {
            DataClassification = SystemMetadata;
        }
        /// <summary>
        /// System ID of the specific record from which the text was extracted.
        /// </summary>
        field(3; "Source System Id"; Guid)
        {
            DataClassification = SystemMetadata;
        }
        /// <summary>
        /// Scenario or purpose for which the text extraction was performed.
        /// </summary>
        field(4; Scenario; Enum "Entity Text Scenario")
        {
            DataClassification = SystemMetadata;
        }
        /// <summary>
        /// Abbreviated text content for quick preview and summary purposes.
        /// </summary>
        field(5; "Preview Text"; Text[1024])
        {
            DataClassification = CustomerContent;
        }
        /// <summary>
        /// Complete text content extracted from the source entity stored as BLOB.
        /// </summary>
        field(6; Text; Blob)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Company, "Source Table Id", "Source System Id", Scenario)
        {
            Clustered = true;
        }
    }
}