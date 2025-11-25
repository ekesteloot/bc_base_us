// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment;

/// <summary>
/// Virtual table that provides statistical information about table sizes, record counts, and storage metrics.
/// This table enables monitoring of database storage usage and performance characteristics for each table.
/// </summary>
/// <remarks>
/// The Table Information table provides essential database administration information including
/// record counts, storage sizes, and compression settings for all tables in the system.
/// This information is crucial for database performance monitoring, storage planning, and optimization.
/// The data is particularly useful for identifying large tables, monitoring growth trends,
/// and making decisions about data archival or cleanup. This table is only available in on-premises
/// deployments where administrators have direct access to the underlying database statistics.
/// </remarks>
table 2000000028 "Table Information"
{
    DataPerCompany = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// The name of the company to which the table data belongs.
        /// </summary>
        field(1; "Company Name"; Text[30])
        {
        }
        /// <summary>
        /// The unique identifier number of the table.
        /// </summary>
        field(2; "Table No."; Integer)
        {
        }
        /// <summary>
        /// The name of the table as defined in the AL source code.
        /// </summary>
        field(3; "Table Name"; Text[30])
        {
        }
        /// <summary>
        /// The current number of records stored in the table.
        /// </summary>
        field(4; "No. of Records"; Integer)
        {
        }
        /// <summary>
        /// The average size of a record in the table, measured in bytes.
        /// </summary>
        field(5; "Record Size"; Decimal)
        {
        }
        /// <summary>
        /// The total size of the table including data and indexes, measured in kilobytes.
        /// </summary>
        field(6; "Size (KB)"; Integer)
        {
        }
        /// <summary>
        /// The compression method applied to the table in the database.
        /// </summary>
        field(7; "Compression"; Option)
        {
            OptionMembers = None,Row,Page,Columnstore,"Columnstore Archive";
        }
        /// <summary>
        /// The size of the actual data stored in the table, measured in kilobytes.
        /// </summary>
        field(8; "Data Size (KB)"; Integer)
        {
        }
        /// <summary>
        /// The size of all indexes associated with the table, measured in kilobytes.
        /// </summary>
        field(9; "Index Size (KB)"; Integer)
        {
        }
    }

    keys
    {
        key(pk; "Company Name", "Table No.")
        {

        }
    }
}