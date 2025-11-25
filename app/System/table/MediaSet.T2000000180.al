// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment;

/// <summary>
/// Manages collections of related media content organized as media sets for complex multimedia presentations and grouped content management.
/// </summary>
/// <remarks>
/// This table enables grouping multiple media items into logical sets for carousel displays, image galleries, and multi-media presentations. Supports company-specific media organization and provides indexing for ordered content display. Used by the platform for complex media management scenarios requiring multiple related items.
/// </remarks>
table 2000000180 "Media Set"
{
    Caption = 'Media Set';
    DataPerCompany = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Unique identifier for the media set used for referencing and grouping related media content.
        /// </summary>
        field(1; ID; Guid)
        {
            Caption = 'ID';
        }
        /// <summary>
        /// Reference to individual media items that are part of this media set collection.
        /// </summary>
        field(2; "Media ID"; Media)
        {
            Caption = 'Media ID';
        }
        /// <summary>
        /// Company context for the media set enabling company-specific content organization and access control.
        /// </summary>
        field(3; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            TableRelation = System.Environment.Company.Name;
        }
        /// <summary>
        /// Sequential index position of media items within the set for ordered presentation and navigation.
        /// </summary>
        field(4; "Media Index"; BigInteger)
        {
            Caption = 'Media Index';
        }
    }

    keys
    {
        key(Key1; ID, "Media ID")
        {
            Clustered = true;
        }
        key(Key2; "Media Index")
        {
        }
        key(Key3; "Company Name")
        {
        }
    }

    fieldgroups
    {
    }
}

