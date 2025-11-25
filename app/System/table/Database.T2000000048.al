// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment;

/// <summary>
/// Virtual table that provides information about databases accessible to the Business Central server.
/// This table enables discovery and management of database connections in multi-database environments.
/// </summary>
/// <remarks>
/// The Database table provides visibility into available databases and their characteristics
/// in environments where multiple databases may be accessible. It includes information about
/// database creators, creation dates, and replication settings for databases that support
/// data synchronization scenarios. This table is only available in on-premises deployments
/// where administrators may have access to multiple database instances. The information
/// is useful for database administration, replication management, and multi-tenant scenarios.
/// </remarks>
table 2000000048 Database
{
    Scope = OnPrem;
    fields
    {
        /// <summary>
        /// The name of the database.
        /// </summary>
        field(1; "Database Name"; Text[128])
        {
        }
        /// <summary>
        /// The name of the user or process that created the database.
        /// </summary>
        field(2; Creator; Text[64])
        {
        }
        /// <summary>
        /// The date when the database was created.
        /// </summary>
        field(3; Created; Date)
        {
        }
        /// <summary>
        /// The replication type configured for the database when participating in data synchronization.
        /// </summary>
        field(4; "Replication Type"; Option)
        {
            OptionMembers = " ",Published,Subscribed,"Published (Merge)","Subscribed (Merge)";
            OptionCaption = ' ,Published,Subscribed,Published (Merge),Subscribed (Merge)';
        }
        /// <summary>
        /// Indicates whether this database record represents the current database being accessed.
        /// </summary>
        field(5; "My Database"; Boolean)
        {
        }
    }

    keys
    {
        key(pk; "Database Name")
        {
        }
        key(fk1; Creator)
        {
        }
        key(fk2; Created)
        {
        }
    }
}