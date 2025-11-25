// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Upgrade;

/// <summary>
/// Virtual table that provides configuration settings for table synchronization during upgrade processes.
/// </summary>
/// <remarks>
/// This table defines how tables should be synchronized during upgrade operations, including mode and target table mappings.
/// Used by the upgrade framework to control data migration and synchronization behavior.
/// The table is scoped to OnPrem and not per-company, making it a system-wide configuration.
/// </remarks>
table 2000000135 "Table Synch. Setup"
{
    DataPerCompany = False;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// The ID of the source table to be synchronized during upgrade.
        /// </summary>
        field(1; "Table ID"; Integer)
        {
        }
        /// <summary>
        /// The ID of the target table for upgrade synchronization operations.
        /// </summary>
        field(2; "Upgrade Table ID"; Integer)
        {
        }
        /// <summary>
        /// The synchronization mode that determines how the table data should be handled during upgrade.
        /// </summary>
        field(3; "Mode"; Option)
        {
            OptionMembers = Check,Copy,Move,Force;
        }
    }

    keys
    {
        key(pk; "Table ID")
        {
        }
    }
}