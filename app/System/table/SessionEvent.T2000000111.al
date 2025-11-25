// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment;

using System.Security.AccessControl;

/// <summary>
/// Records session events and activities for users within Business Central, providing audit trail and session management capabilities.
/// </summary>
/// <remarks>
/// This table captures user session events including logon, logoff, start, stop, and close activities across different
/// client types and server instances. Provides session tracking with client information, timestamps,
/// and session identifiers for security auditing and system monitoring. Supports various client types from web clients
/// to mobile devices and services. Used by the session management framework for monitoring user activity, security
/// auditing, and troubleshooting session-related issues.
/// </remarks>
table 2000000111 "Session Event"
{
    Caption = 'Session Event';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// Security ID of the user associated with this session event.
        /// </summary>
        field(1; "User SID"; Guid)
        {
            Caption = 'User SID';
            TableRelation = User."User Security ID";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        /// <summary>
        /// Identifier of the server instance where the session event occurred.
        /// </summary>
        field(2; "Server Instance ID"; Integer)
        {
            Caption = 'Server Instance ID';
            TableRelation = "Server Instance"."Server Instance ID";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        /// <summary>
        /// Unique identifier for the session within the server instance.
        /// </summary>
        field(3; "Session ID"; Integer)
        {
            Caption = 'Session ID';
        }
        /// <summary>
        /// Type of session event that occurred (Logon, Logoff, Start, Stop, Close).
        /// </summary>
        field(4; "Event Type"; Option)
        {
            Caption = 'Event Type';
            OptionCaption = 'Logon,Logoff,Start,Stop,Close';
            OptionMembers = Logon,Logoff,Start,Stop,Close;
        }
        /// <summary>
        /// Date and time when the session event occurred.
        /// </summary>
        field(5; "Event Datetime"; DateTime)
        {
            Caption = 'Event Datetime';
        }
        /// <summary>
        /// Type of client application that initiated the session.
        /// </summary>
        field(6; "Client Type"; Option)
        {
            Caption = 'Client Type';
            OptionCaption = 'Windows Client,SharePoint Client,Web Service,Client Service,NAS,Background,Management Client,Web Client,Unknown,Tablet,Phone,Desktop';
            OptionMembers = "Windows Client","SharePoint Client","Web Service","Client Service",NAS,Background,"Management Client","Web Client",Unknown,Tablet,Phone,Desktop;
        }
        /// <summary>
        /// Name of the database where the session was established.
        /// </summary>
        field(7; "Database Name"; Text[250])
        {
            Caption = 'Database Name';
        }
        /// <summary>
        /// Name of the client computer from which the session was initiated.
        /// </summary>
        field(8; "Client Computer Name"; Text[250])
        {
            Caption = 'Client Computer Name';
        }
        /// <summary>
        /// User identifier for the session, typically the login name.
        /// </summary>
        field(9; "User ID"; Text[132])
        {
            Caption = 'User ID';
        }
        /// <summary>
        /// Additional comment or information about the session event.
        /// </summary>
        field(10; Comment; Text[132])
        {
            Caption = 'Comment';
        }
        /// <summary>
        /// Globally unique identifier for the session across all server instances.
        /// </summary>
        field(11; "Session Unique ID"; Guid)
        {
            Caption = 'Session Unique ID';
        }
    }

    keys
    {
        key(Key1; "User SID", "Server Instance ID", "Session ID", "Event Datetime", "Event Type")
        {
            Clustered = true;
        }
        key(Key2; "Session Unique ID")
        {
        }
        key(Key3; "Event Datetime")
        {
        }
    }

    fieldgroups
    {
    }
}

