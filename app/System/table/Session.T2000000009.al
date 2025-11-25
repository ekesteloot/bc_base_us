// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment;

/// <summary>
/// Virtual table that provides information about active user sessions connected to the Business Central server.
/// This table enables monitoring of current database connections, user activity, and session management.
/// </summary>
/// <remarks>
/// The Session table is essential for session monitoring, user management, and system administration.
/// It provides real-time information about who is connected to the system, when they logged in,
/// and various session attributes. This information is commonly used for user activity reports,
/// connection monitoring, and security auditing. The table only shows active sessions and
/// automatically reflects changes as users connect and disconnect.
/// </remarks>
table 2000000009 Session
{
    DataPerCompany = false;
    Scope = Cloud;
    fields
    {
        /// <summary>
        /// Unique identifier for the database connection session.
        /// </summary>
        field(1; "Connection ID"; Integer)
        {
        }
        /// <summary>
        /// The user ID of the user associated with this session.
        /// </summary>
        field(2; "User ID"; Text[64])
        {
        }
        /// <summary>
        /// Indicates whether this session record represents the current user's own session.
        /// </summary>
        field(3; "My Session"; Boolean)
        {
        }
        /// <summary>
        /// The time when the user logged into this session.
        /// </summary>
        field(5; "Login Time"; Time)
        {
        }
        /// <summary>
        /// The date when the user logged into this session.
        /// </summary>
        field(6; "Login Date"; Date)
        {
        }
        /// <summary>
        /// The name of the database that the session is connected to.
        /// </summary>
        field(16; "Database Name"; Text[128])
        {
        }
        /// <summary>
        /// The name of the application or client used to connect to the session.
        /// </summary>
        field(17; "Application Name"; Text[64])
        {
        }
        /// <summary>
        /// The authentication method used to establish the session.
        /// </summary>
        field(18; "Login Type"; Option)
        {
            OptionMembers = None,Windows,"Username and Password","Access Control Service";
        }
        /// <summary>
        /// The name of the computer or host from which the session was initiated.
        /// </summary>
        field(19; "Host Name"; Text[64])
        {
        }
    }

    keys
    {
        key(pk; "Connection ID")
        {
        }
        key(fk1; "User ID")
        {
        }
    }
}