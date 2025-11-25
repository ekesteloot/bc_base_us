// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment;

/// <summary>
/// Stores configuration and status information for Business Central server instances including connection details and operational status.
/// </summary>
/// <remarks>
/// This table manages server instance registry for multi-tenant and distributed deployments enabling server monitoring. Tracks server status, connection endpoints, and configuration versions for server management. Used by the platform for server discovery, health monitoring, and tenant distribution.
/// </remarks>
table 2000000112 "Server Instance"
{
    Caption = 'Server Instance';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Auto-incrementing unique identifier for the server instance used for server registration and tracking.
        /// </summary>
        field(1; "Server Instance ID"; Integer)
        {
            AutoIncrement = true;
            Caption = 'Server Instance ID';
        }
        /// <summary>
        /// Windows service name for the Business Central server instance used for service management operations.
        /// </summary>
        field(2; "Service Name"; Text[250])
        {
            Caption = 'Service Name';
        }
        /// <summary>
        /// Computer name or hostname where the server instance is running for network identification and connection routing.
        /// </summary>
        field(3; "Server Computer Name"; Text[250])
        {
            Caption = 'Server Computer Name';
        }
        /// <summary>
        /// Timestamp of the last activity or heartbeat from the server instance for health monitoring and status tracking.
        /// </summary>
        field(4; "Last Active"; DateTime)
        {
            Caption = 'Last Active';
        }
        /// <summary>
        /// Display name of the server instance used for identification and administrative purposes.
        /// </summary>
        field(5; "Server Instance Name"; Text[250])
        {
            Caption = 'Server Instance Name';
        }
        /// <summary>
        /// TCP port number for client connections to the server instance enabling network communication and load balancing.
        /// </summary>
        field(6; "Server Port"; Integer)
        {
            Caption = 'Server Port';
        }
        /// <summary>
        /// TCP port number for management and administrative operations on the server instance.
        /// </summary>
        field(7; "Management Port"; Integer)
        {
            Caption = 'Management Port';
        }
        /// <summary>
        /// Current operational status of the server instance indicating availability and health state.
        /// </summary>
        field(8; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Started,Stopped,Crashed';
            OptionMembers = Started,Stopped,Crashed;
        }
        /// <summary>
        /// Version number of the last tenant configuration applied to this server instance for configuration synchronization.
        /// </summary>
        field(9; "Last Tenant Config Version"; BigInteger)
        {
            Caption = 'Last Tenant Config Version';
        }
    }

    keys
    {
        key(Key1; "Server Instance ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

