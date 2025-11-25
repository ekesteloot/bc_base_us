// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment;

/// <summary>
/// Stores thumbnail images for media files at the tenant level, providing optimized image previews for improved user experience.
/// This table manages thumbnail generation, storage, and retrieval for media content across the platform.
/// </summary>
/// <remarks>
/// This table contains thumbnail representations of media files, enabling fast preview displays without loading full-size images.
/// Each thumbnail includes dimension information and MIME type for proper rendering and optimization.
/// Data is not company-specific but tracks company association for proper media scope management.
/// Extensibility points include custom thumbnail generation logic and image processing events.
/// Related tables: Tenant Media for the full media files, Media and MediaSet for media management.
/// </remarks>
table 2000000185 "Tenant Media Thumbnails"
{
    Caption = 'Tenant Media Thumbnails';
    DataPerCompany = false;
    Scope = Cloud;
    InherentPermissions = rX;

    fields
    {
        /// <summary>
        /// Unique identifier for the thumbnail record, providing primary key functionality for thumbnail management.
        /// </summary>
        field(1; ID; Guid)
        {
            Caption = 'ID';
        }
        /// <summary>
        /// Reference to the original media file for which this thumbnail was generated, establishing the media relationship.
        /// </summary>
        field(2; "Media ID"; Guid)
        {
            Caption = 'Media ID';
            TableRelation = "Tenant Media".ID WHERE(ID = FIELD("Media ID"));
        }
        /// <summary>
        /// Binary data containing the thumbnail image content, optimized for quick display and reduced storage requirements.
        /// </summary>
        field(3; Content; BLOB)
        {
            Caption = 'Content';
            SubType = Bitmap;
        }
        /// <summary>
        /// MIME type of the thumbnail image, indicating the image format and encoding for proper browser rendering.
        /// </summary>
        field(4; "Mime Type"; Text[100])
        {
            Caption = 'Mime Type';
        }
        /// <summary>
        /// Height dimension of the thumbnail image in pixels, used for layout calculations and display optimization.
        /// </summary>
        field(5; Height; Integer)
        {
            Caption = 'Height';
        }
        /// <summary>
        /// Width dimension of the thumbnail image in pixels, used for layout calculations and display optimization.
        /// </summary>
        field(6; Width; Integer)
        {
            Caption = 'Width';
        }
        /// <summary>
        /// Name of the company context associated with this thumbnail, enabling company-specific media management and access control.
        /// </summary>
        field(7; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            TableRelation = System.Environment.Company.Name;
        }
        /// <summary>
        /// Indicates whether the thumbnail data is embedded directly in the record or stored externally, affecting retrieval performance.
        /// </summary>
        field(8; Embedded; Boolean)
        {
            Caption = 'Embedded';
        }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
        key(Key2; "Media ID")
        {
        }
    }

    fieldgroups
    {
    }
}

