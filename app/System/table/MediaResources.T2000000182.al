// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment;

/// <summary>
/// Manages media resource references and binary content for system-wide media assets and application resources.
/// </summary>
/// <remarks>
/// This table provides a registry for media resources used across the application including system icons, images, and documents. Supports both individual media items and media sets with direct binary content storage. Used by the platform for media resource management and caching in cloud environments.
/// </remarks>
table 2000000182 "Media Resources"
{
    Caption = 'Media Resources';
    DataPerCompany = false;
    Scope = Cloud;
    InherentPermissions = rX;

    fields
    {
        /// <summary>
        /// Unique code identifier for the media resource used for referencing and lookup operations.
        /// </summary>
        field(1; "Code"; Code[50])
        {
            Caption = 'Code';
        }
        /// <summary>
        /// Reference to a media set containing multiple related media items for grouped content management.
        /// </summary>
        field(2; "MediaSet Reference"; MediaSet)
        {
            Caption = 'MediaSet Reference';
        }
        /// <summary>
        /// Reference to an individual media item for single content management and display.
        /// </summary>
        field(3; "Media Reference"; Media)
        {
            Caption = 'Media Reference';
        }
        /// <summary>
        /// Binary content storage for media data including images, documents, and other file types.
        /// </summary>
        field(4; Blob; BLOB)
        {
            Caption = 'Blob';
            SubType = UserDefined;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

