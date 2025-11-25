// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment;

/// <summary>
/// Stores media files and binary content for tenant-wide use across Business Central applications.
/// Manages images, documents, and other media content with metadata and access control.
/// </summary>
/// <remarks>
/// This table provides centralized media storage for tenant applications, supporting file upload,
/// image management, and content delivery. Integrates with media controls, attachment systems,
/// and content management features for enhanced user interface and document handling capabilities.
/// </remarks>
table 2000000184 "Tenant Media"
{
    Caption = 'Tenant Media';
    DataPerCompany = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// Unique global identifier for the media file or content item.
        /// </summary>
        field(1; ID; Guid)
        {
            Caption = 'ID';
        }
        /// <summary>
        /// Descriptive text explaining the purpose or content of the media file.
        /// </summary>
        field(2; Description; Text[250])
        {
            Caption = 'Description';
        }
        /// <summary>
        /// Binary storage containing the actual media content data.
        /// </summary>
        field(3; Content; BLOB)
        {
            Caption = 'Content';
            SubType = Bitmap;
        }
        /// <summary>
        /// MIME type specification defining the format and content type of the media file.
        /// </summary>
        field(4; "Mime Type"; Text[100])
        {
            Caption = 'Mime Type';
        }
        /// <summary>
        /// Height dimension in pixels for image media content.
        /// </summary>
        field(5; Height; Integer)
        {
            Caption = 'Height';
        }
        /// <summary>
        /// Width dimension in pixels for image media content.
        /// </summary>
        field(6; Width; Integer)
        {
            Caption = 'Width';
        }
        /// <summary>
        /// Company context for company-specific media content restrictions.
        /// </summary>
        field(7; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            TableRelation = System.Environment.Company.Name;
        }
        /// <summary>
        /// Date and time when the media content expires and should be removed.
        /// </summary>
        field(8; "Expiration Date"; DateTime)
        {
            Caption = 'Expiration Date';
        }
        /// <summary>
        /// Indicates whether this media content should be excluded from caching mechanisms.
        /// </summary>
        field(10; "Prohibit Cache"; Boolean)
        {
            Caption = 'Prohibit Cache';
        }
        /// <summary>
        /// Original file name of the uploaded media content.
        /// </summary>
        field(11; "File Name"; Text[250])
        {
            Caption = 'File Name';
        }
        /// <summary>
        /// Security token for controlling access to the media content.
        /// </summary>
        field(12; "Security Token"; Text[100])
        {
            Caption = 'Security Token';
        }
        /// <summary>
        /// User identifier of the person who uploaded or created this media content.
        /// </summary>
        field(13; "Creating User"; Text[50])
        {
            Caption = 'Creating User';
        }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
        key(Key2; "Security Token")
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

