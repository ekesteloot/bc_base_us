// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Security;

using System.Environment;
using System.Security.AccessControl;

/// <summary>
/// Provides secure, encrypted storage for extension data with support for different scope levels.
/// Manages application-specific data storage with encryption and access control based on scope boundaries.
/// </summary>
/// <remarks>
/// This table enables extensions to store sensitive configuration data, user preferences, and application state
/// securely with automatic encryption. Supports module, company, user, and combined scopes for flexible
/// data isolation. Integrates with the Isolated Storage framework for secure data management and compliance.
/// </remarks>
table 2000000107 "Isolated Storage"
{
    Caption = 'Isolated Storage';
    DataPerCompany = false;
    Scope = OnPrem;
    ReplicateData = false;

    fields
    {
        /// <summary>
        /// Unique identifier of the extension application that owns this storage entry.
        /// </summary>
        field(1; "App Id"; Guid)
        {
            Caption = 'App Id';
        }

        /// <summary>
        /// Scope level determining the access boundaries for this storage entry.
        /// </summary>
        field(2; Scope; Option)
        {
            Caption = 'Scope';
            OptionCaption = 'Module,Company,User,CompanyAndUser';
            OptionMembers = Module,Company,User,CompanyAndUser;
        }

        /// <summary>
        /// Company name context for company-scoped storage entries.
        /// </summary>
        field(3; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            TableRelation = Company.Name;
        }

        /// <summary>
        /// User security identifier for user-scoped storage entries.
        /// </summary>
        field(4; "User Id"; Guid)
        {
            Caption = 'User Id';
            TableRelation = User."User Security ID";
            DataClassification = EndUserIdentifiableInformation;
            //This property is currently not supported
            //TestTableRelation = false;
        }

        /// <summary>
        /// Key identifier for the stored data within the application scope.
        /// </summary>
        field(5; "Key"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Key';
        }

        /// <summary>
        /// Binary storage containing the encrypted or plain text data value.
        /// </summary>
        field(6; Value; BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'Value';
        }

        /// <summary>
        /// Current encryption status of the stored value data.
        /// </summary>
        field(7; "Encryption Status"; Option)
        {
            Caption = 'Encryption Status';
            OptionCaption = 'PlainText,Encrypted,PendingForEncryption';
            OptionMembers = PlainText,Encrypted,PendingForEncryption;
        }

        /// <summary>
        /// Target value type indicating whether the data should be treated as secret text.
        /// </summary>
        field(8; "Target Value Type"; Option)
        {
            Caption = 'Target Value Type';
            OptionCaption = 'Text,SecretText';
            OptionMembers = Text,SecretText;
        }
    }

    keys
    {
        key(Key1; "App Id", Scope, "Company Name", "User Id", "Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

