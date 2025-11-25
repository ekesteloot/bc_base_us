// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Reflection;

/// <summary>
/// Virtual table that provides metadata information about all keys defined for tables in the system.
/// This table enables introspection of table indexing strategies, key definitions, and performance characteristics.
/// </summary>
/// <remarks>
/// The Key table is essential for understanding table performance characteristics and indexing strategies.
/// It provides detailed information about primary keys, secondary keys, SIFT (Sum Index Field Technology) keys,
/// and their corresponding SQL indexes. This information is crucial for performance analysis, query optimization,
/// and understanding data access patterns. The table includes information about key enablement status,
/// SQL index maintenance, and SIFT index configuration, which directly impacts query performance and
/// data aggregation capabilities in Business Central applications.
/// </remarks>
table 2000000063 "Key"
{
    DataPerCompany = false;
    Scope = Cloud;
    fields
    {
        /// <summary>
        /// The table number that contains this key definition.
        /// </summary>
        field(1; TableNo; Integer)
        {
        }
        /// <summary>
        /// The sequential number of the key within the table.
        /// </summary>
        field(2; "No."; Integer)
        {
        }
        /// <summary>
        /// The name of the table that contains this key.
        /// </summary>
        field(3; TableName; Text[30])
        {
        }
        /// <summary>
        /// The field names that compose this key, listed in order of precedence.
        /// </summary>
        field(4; "Key"; Text[250])
        {
        }
        /// <summary>
        /// The fields that are maintained in SIFT (Sum Index Field Technology) for aggregation purposes.
        /// </summary>
        field(5; SumIndexFields; Text[250])
        {
        }
        /// <summary>
        /// The name of the corresponding SQL index created in the database for this key.
        /// </summary>
        field(6; SQLIndex; Text[250])
        {
        }
        /// <summary>
        /// Indicates whether this key is currently enabled and available for use.
        /// </summary>
        field(7; Enabled; Boolean)
        {
        }
        /// <summary>
        /// Indicates whether the SQL index for this key is actively maintained in the database.
        /// </summary>
        field(8; MaintainSQLIndex; Boolean)
        {
        }
        /// <summary>
        /// Indicates whether the SIFT index for this key is actively maintained for aggregation queries.
        /// </summary>
        field(9; MaintainSIFTIndex; Boolean)
        {
        }
        /// <summary>
        /// Indicates whether this key is defined as the clustered index in the database.
        /// </summary>
        field(10; Clustered; Boolean)
        {
        }
        /// <summary>
        /// The obsolete state indicating whether the key is obsolete, pending removal, or removed.
        /// </summary>
        field(11; ObsoleteState; Option)
        {
            Caption = 'ObsoleteState';
            OptionMembers = No,Pending,Removed;
        }
        /// <summary>
        /// The reason provided when the key was marked as obsolete.
        /// </summary>
        field(12; ObsoleteReason; Text[30])
        {
            Caption = 'ObsoleteReason';
        }
        /// <summary>
        /// Indicates whether this key enforces uniqueness constraints on the field combination.
        /// </summary>
        field(13; Unique; Boolean)
        {
        }
    }

    keys
    {
        key(pk; TableNo, "No.")
        {

        }
    }
}
