// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Integration;

/// <summary>
/// Stores synchronization status and settings for tables in Intelligent Cloud data migration scenarios.
/// </summary>
/// <remarks>
/// This table manages the synchronization status of individual tables during Intelligent Cloud migration processes.
/// Each record tracks the sync version, replication settings, and blocking status for specific tables and companies.
/// Essential for managing cloud migration processes, ensuring data consistency, and controlling table-level synchronization behavior.
/// </remarks>
table 2000000173 "Intelligent Cloud Status"
{
    Caption = 'Intelligent Cloud Status';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// The name of the table being tracked for Intelligent Cloud synchronization.
        /// </summary>
        field(1; "Table Name"; Text[250])
        {
            Caption = 'Table Name';
        }
        /// <summary>
        /// The name of the company that this table synchronization status applies to.
        /// </summary>
        field(2; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
        }
        /// <summary>
        /// The numeric identifier of the table being synchronized.
        /// </summary>
        field(3; "Table Id"; Integer)
        {
            Caption = 'Table Id';
        }
        /// <summary>
        /// The version number of the last successful synchronization for this table.
        /// </summary>
        field(4; "Synced Version"; BigInteger)
        {
            Caption = 'Synced Version';
        }
        /// <summary>
        /// Indicates whether synchronization is blocked for this table.
        /// </summary>
        field(5; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        /// <summary>
        /// Indicates whether data replication is enabled for this table.
        /// </summary>
        field(6; "Replicate Data"; Boolean)
        {
            Caption = 'Replicate Data';
        }
        /// <summary>
        /// Indicates whether existing cloud data should be preserved during synchronization.
        /// </summary>
        field(7; "Preserve Cloud Data"; Boolean)
        {
            Caption = 'Preserve Cloud Data';
        }
    }

    keys
    {
        key(Key1; "Table Name", "Company Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

