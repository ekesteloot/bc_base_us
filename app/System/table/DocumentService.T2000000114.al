// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Integration;

/// <summary>
/// Stores configuration for document service integrations, enabling Business Central to connect with external document management systems.
/// </summary>
/// <remarks>
/// This table maintains connection settings and authentication information for document services such as SharePoint,
/// OneDrive, or other document repositories. Supports both legacy authentication and OAuth2 authentication methods.
/// Stores service endpoints, credentials, and folder configurations for document storage and retrieval operations.
/// Used by the document service framework to establish connections with external document management systems
/// and provide document storage capabilities within Business Central.
/// </remarks>
table 2000000114 "Document Service"
{
    Caption = 'Document Service';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Unique identifier for the document service configuration.
        /// </summary>
        field(1; "Service ID"; Code[30])
        {
            Caption = 'Service ID';
        }
        /// <summary>
        /// Human-readable description of the document service.
        /// </summary>
        field(3; Description; Text[80])
        {
            Caption = 'Description';
        }
        /// <summary>
        /// URL or endpoint location of the document service.
        /// </summary>
        field(5; Location; Text[250])
        {
            Caption = 'Location';
        }
        /// <summary>
        /// Username for authentication with the document service.
        /// </summary>
        field(7; "User Name"; Text[128])
        {
            Caption = 'User Name';
        }
        /// <summary>
        /// Password for authentication with the document service (masked for security).
        /// </summary>
        field(9; Password; Text[128])
        {
            Caption = 'Password';
            ExtendedDatatype = Masked;
        }
        /// <summary>
        /// Name or identifier of the document repository within the service.
        /// </summary>
        field(11; "Document Repository"; Text[250])
        {
            Caption = 'Document Repository';
        }
        /// <summary>
        /// Default folder path for document operations within the repository.
        /// </summary>
        field(13; Folder; Text[250])
        {
            Caption = 'Folder';
        }
        /// <summary>
        /// OAuth2 client identifier for authentication.
        /// </summary>
        field(15; "Client Id"; Text[250])
        {
            Caption = 'Client Id';
        }
        /// <summary>
        /// OAuth2 client secret for authentication (obsolete field).
        /// </summary>
        field(17; "Client Secret"; Text[250])
        {
            Caption = 'Client Secret';
            ObsoleteReason = 'Unused field.';
            ObsoleteState = Pending;
            ObsoleteTag = '17.0';
        }
        /// <summary>
        /// OAuth2 redirect URL for authentication flow.
        /// </summary>
        field(19; "Redirect URL"; Text[2048])
        {
            Caption = 'Redirect URL';
        }
        /// <summary>
        /// Authentication method to use for connecting to the document service.
        /// </summary>
        field(21; "Authentication Type"; Option)
        {
            Caption = 'Authentication Type';
            OptionCaption = 'Legacy,OAuth2';
            OptionMembers = Legacy,OAuth2;
        }
        /// <summary>
        /// Secure key identifier for storing OAuth2 client secret.
        /// </summary>
        field(23; "Client Secret Key"; Guid)
        {
            Caption = 'Client Secret Key';
        }
    }

    keys
    {
        key(Key1; "Service ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Service ID", Description)
        {
        }
    }
}

