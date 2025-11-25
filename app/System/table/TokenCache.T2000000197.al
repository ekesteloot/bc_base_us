// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Security.Authentication;

using System.Security.AccessControl;

/// <summary>
/// Stores authentication token cache data for user session management and single sign-on scenarios.
/// Manages cached authentication tokens to optimize user authentication performance and experience.
/// </summary>
/// <remarks>
/// This table provides secure storage for authentication tokens and session data, supporting Azure AD
/// integration, OAuth flows, and session persistence. Integrates with authentication services,
/// token refresh mechanisms, and user identity management for seamless authentication experiences.
/// </remarks>
table 2000000197 "Token Cache"
{
    Caption = 'Token Cache';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;
    CompressionType = None;

    fields
    {
        /// <summary>
        /// Security identifier of the user to whom this token cache belongs.
        /// </summary>
        field(1; "User Security ID"; Guid)
        {
            Caption = 'User Security ID';
            TableRelation = User."User Security ID";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        /// <summary>
        /// Unique identifier for the user in the authentication system.
        /// </summary>
        field(2; "User Unique ID"; Guid)
        {
            Caption = 'User Unique ID';
        }
        /// <summary>
        /// Identifier of the tenant for multi-tenant authentication scenarios.
        /// </summary>
        field(3; "Tenant ID"; Guid)
        {
            Caption = 'Tenant ID';
        }
        /// <summary>
        /// Timestamp when the token cache data was last written or updated.
        /// </summary>
        field(4; "Cache Write Time"; DateTime)
        {
            Caption = 'Cache Write Time';
        }
        /// <summary>
        /// Binary storage containing the encrypted authentication token cache data.
        /// </summary>
        field(5; "Cache Data"; BLOB)
        {
            Caption = 'Cache Data';
        }
        /// <summary>
        /// String representation of the user's unique identifier for authentication.
        /// </summary>
        field(6; "User String Unique ID"; Text[80])
        {
            Caption = 'User String Unique ID';
        }
        /// <summary>
        /// String representation of the tenant's unique identifier for authentication.
        /// </summary>
        field(7; "Tenant String Unique ID"; Text[80])
        {
            Caption = 'Tenant String Unique ID';
        }
        /// <summary>
        /// Home account identifier for Azure AD authentication and cross-tenant scenarios.
        /// </summary>
        field(8; "Home Account ID"; Text[120])
        {
            Caption = 'Home Account ID';
        }
        /// <summary>
        /// Login hint used for authentication optimization and user experience improvement.
        /// </summary>
        field(9; "Login Hint"; Text[120])
        {
            Caption = 'Login Hint';
        }
        /// <summary>
        /// Session-specific cache key for associating tokens with user sessions.
        /// </summary>
        field(10; "Session Cache Key"; Text[120])
        {
            Caption = 'Session Cache Key';
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

