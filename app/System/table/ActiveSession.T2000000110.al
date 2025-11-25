// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment;

using System.Security.AccessControl;

/// <summary>
/// Stores information about currently active user sessions in the Business Central tenant.
/// Tracks user connections, client types, and session activity for monitoring and management purposes.
/// </summary>
/// <remarks>
/// This table provides real-time visibility into user sessions across all server instances and client types.
/// Integrates with session management systems, monitoring tools, and user activity tracking for
/// administrative oversight and performance analysis. Used for session administration and security monitoring.
/// </remarks>
table 2000000110 "Active Session"
{
    Caption = 'Active Session';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// Security identifier of the user who owns this active session.
        /// </summary>
        field(1; "User SID"; Guid)
        {
            Caption = 'User SID';
            TableRelation = User."User Security ID";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        /// <summary>
        /// Identifier of the server instance hosting this session.
        /// </summary>
        field(2; "Server Instance ID"; Integer)
        {
            Caption = 'Server Instance ID';
            TableRelation = "Server Instance"."Server Instance ID";
        }
        /// <summary>
        /// Unique numeric identifier of the session within the server instance.
        /// </summary>
        field(3; "Session ID"; Integer)
        {
            Caption = 'Session ID';
        }
        /// <summary>
        /// Name of the server instance hosting this session.
        /// </summary>
        field(4; "Server Instance Name"; Text[250])
        {
            Caption = 'Server Instance Name';
        }
        /// <summary>
        /// Name of the computer or server hosting the Business Central service.
        /// </summary>
        field(5; "Server Computer Name"; Text[250])
        {
            Caption = 'Server Computer Name';
        }
        /// <summary>
        /// Login identifier of the user for this session.
        /// </summary>
        field(6; "User ID"; Text[132])
        {
            Caption = 'User ID';
        }
        /// <summary>
        /// Type of client application being used for this session.
        /// </summary>
        field(7; "Client Type"; Option)
        {
            Caption = 'Client Type';
            OptionCaption = 'Windows Client,SharePoint Client,Web Service,Client Service,NAS,Background,Management Client,Web Client,Unknown,Tablet,Phone,Desktop,Teams,Child Session';
            OptionMembers = "Windows Client","SharePoint Client","Web Service","Client Service",NAS,Background,"Management Client","Web Client",Unknown,Tablet,Phone,Desktop,Teams,"Child Session";
        }
        /// <summary>
        /// Name of the computer or device from which the client is connecting.
        /// </summary>
        field(8; "Client Computer Name"; Text[250])
        {
            Caption = 'Client Computer Name';
        }
        /// <summary>
        /// Date and time when this session was established.
        /// </summary>
        field(9; "Login Datetime"; DateTime)
        {
            Caption = 'Login Datetime';
        }
        /// <summary>
        /// Name of the database that this session is connected to.
        /// </summary>
        field(10; "Database Name"; Text[250])
        {
            Caption = 'Database Name';
        }
        /// <summary>
        /// Global unique identifier for this session across all server instances.
        /// </summary>
        field(11; "Session Unique ID"; Guid)
        {
            Caption = 'Session Unique ID';
        }
    }

    keys
    {
        key(Key1; "Server Instance ID", "Session ID")
        {
            Clustered = true;
        }
        key(Key2; "Login Datetime")
        {
        }
        key(Key3; "User SID", "Client Type")
        {
        }
    }

    fieldgroups
    {
    }
}

