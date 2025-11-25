// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment;

/// <summary>
/// Stores multimedia content including images, documents, and other binary files with metadata for content management and security.
/// </summary>
/// <remarks>
/// This table manages media storage with security token validation, expiration control, and caching policies. Supports company-specific media isolation and provides metadata for content type identification and dimension management. Used by the platform for UI media display and document attachment functionality.
/// </remarks>
table 2000000181 Media
{
    Caption = 'Media';
    DataPerCompany = false;
    Scope = OnPrem;
    InherentPermissions = rX;

    fields
    {
        /// <summary>
        /// Unique identifier for the media record used for referencing and linking media content.
        /// </summary>
        field(1; ID; Guid)
        {
            Caption = 'ID';
        }
        /// <summary>
        /// Descriptive text providing context and identification for the media content.
        /// </summary>
        field(2; Description; Text[250])
        {
            Caption = 'Description';
        }
        /// <summary>
        /// Binary content data storing the actual media file including images, documents, or other multimedia data.
        /// </summary>
        field(3; Content; BLOB)
        {
            Caption = 'Content';
            SubType = Bitmap;
        }
        /// <summary>
        /// MIME type specification defining the content format and enabling proper content handling and display.
        /// </summary>
        field(4; "Mime Type"; Text[100])
        {
            Caption = 'Mime Type';
        }
        /// <summary>
        /// Pixel height dimension for image content used for display sizing and layout calculations.
        /// </summary>
        field(5; Height; Integer)
        {
            Caption = 'Height';
        }
        /// <summary>
        /// Pixel width dimension for image content used for display sizing and layout calculations.
        /// </summary>
        field(6; Width; Integer)
        {
            Caption = 'Width';
        }
        /// <summary>
        /// Company context for the media content enabling company-specific media isolation and access control.
        /// </summary>
        field(7; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            TableRelation = System.Environment.Company.Name;
        }
        /// <summary>
        /// Expiration timestamp controlling media lifecycle and enabling automatic cleanup of temporary content.
        /// </summary>
        field(8; "Expiration Date"; DateTime)
        {
            Caption = 'Expiration Date';
        }
        /// <summary>
        /// Cache control flag preventing media content from being cached for security or freshness requirements.
        /// </summary>
        field(10; "Prohibit Cache"; Boolean)
        {
            Caption = 'Prohibit Cache';
        }
        /// <summary>
        /// Original file name for the media content preserving source file identification and download naming.
        /// </summary>
        field(11; "File Name"; Text[250])
        {
            Caption = 'File Name';
        }
        /// <summary>
        /// Security token for access validation and preventing unauthorized media access or manipulation.
        /// </summary>
        field(12; "Security Token"; Text[100])
        {
            Caption = 'Security Token';
        }
        /// <summary>
        /// User identifier who created the media record for audit trail and ownership tracking.
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

