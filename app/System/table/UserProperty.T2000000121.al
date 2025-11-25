// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Security.AccessControl;

/// <summary>
/// Stores extended authentication properties and security credentials for user accounts.
/// Manages user authentication data, API keys, and directory integration information.
/// </summary>
/// <remarks>
/// This table provides secure storage for user authentication credentials, web service keys,
/// and Azure Active Directory integration properties. Integrates with authentication systems,
/// API access management, and directory synchronization for user credential management.
/// </remarks>
table 2000000121 "User Property"
{
    Caption = 'User Property';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;
    InherentPermissions = rX;

    fields
    {
        /// <summary>
        /// Security identifier of the user to whom these properties belong.
        /// </summary>
        field(1; "User Security ID"; Guid)
        {
            Caption = 'User Security ID';
            TableRelation = User."User Security ID";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        /// <summary>
        /// Encrypted password credential for user authentication.
        /// </summary>
        field(2; Password; Text[80])
        {
            Caption = 'Password';
        }
        /// <summary>
        /// Name identifier used for external authentication and directory integration.
        /// </summary>
        field(3; "Name Identifier"; Text[250])
        {
            Caption = 'Name Identifier';
        }
        /// <summary>
        /// Authentication key for secure user verification and access control.
        /// </summary>
        field(4; "Authentication Key"; Text[80])
        {
            Caption = 'Authentication Key';
        }
        /// <summary>
        /// Web services access key for API authentication and service integration.
        /// </summary>
        field(5; "WebServices Key"; Text[80])
        {
            Caption = 'WebServices Key';
        }
        /// <summary>
        /// Expiration date and time for the web services access key.
        /// </summary>
        field(6; "WebServices Key Expiry Date"; DateTime)
        {
            Caption = 'WebServices Key Expiry Date';
        }
        /// <summary>
        /// Object identifier used for authentication with external systems.
        /// </summary>
        field(7; "Authentication Object ID"; Text[80])
        {
            Caption = 'Authentication Object ID';
        }
        /// <summary>
        /// Legacy directory role identifier field (obsolete).
        /// </summary>
        field(8; "Directory Role ID"; Text[80])
        {
            Caption = 'Directory Role ID';
            ObsoleteReason = 'This field is deprecated in favour of the "Directory Role ID List" field.';
            ObsoleteState = Removed;
        }
        /// <summary>
        /// Binary storage containing the list of directory role identifiers for Azure AD integration.
        /// </summary>
        field(9; "Directory Role ID List"; BLOB)
        {
            Caption = 'Directory Role ID List';
        }
        /// <summary>
        /// Unique identifier used for telemetry data collection and user activity tracking.
        /// </summary>
        field(10; "Telemetry User ID"; Guid)
        {
            Caption = 'Telemetry User ID';
        }
    }

    keys
    {
        key(Key1; "User Security ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

