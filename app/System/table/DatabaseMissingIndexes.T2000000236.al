// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Diagnostics;

/// <summary>
/// Virtual table that provides information about database indexes that could improve query performance but are currently missing.
/// </summary>
/// <remarks>
/// This table exposes database engine recommendations for missing indexes that could significantly improve
/// query performance. Essential for database administrators and performance analysts to identify optimization
/// opportunities and understand query patterns that would benefit from additional indexing. The table includes
/// impact analysis and cost-benefit information to help prioritize index creation decisions.
/// Used for proactive database performance tuning and optimization planning.
/// </remarks>
table 2000000236 "Database Missing Indexes"
{
    DataPerCompany = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// A unique handle identifying this missing index recommendation.
        /// </summary>
        field(1; "Index Handle"; Integer)
        {
        }
        /// <summary>
        /// The name of the table that would benefit from the missing index.
        /// </summary>
        field(2; "Table Name"; Text[128])
        {
        }
        /// <summary>
        /// The extension ID associated with the table requiring the missing index.
        /// </summary>
        field(3; "Extension Id"; Guid)
        {
        }
        /// <summary>
        /// The columns that should be included in the index for equality predicates.
        /// </summary>
        field(4; "Index Equality Columns"; Text[2048])
        {
        }
        /// <summary>
        /// The columns that should be included in the index for inequality predicates.
        /// </summary>
        field(5; "Index Inequality Columns"; Text[2048])
        {
        }
        /// <summary>
        /// Additional columns that should be included in the index for covering queries.
        /// </summary>
        field(6; "Index Include Columns"; Text[2048])
        {
        }
        /// <summary>
        /// The SQL statement or query pattern that would benefit from this index.
        /// </summary>
        field(7; "Statement"; Text[2048])
        {
        }
        /// <summary>
        /// The number of times user queries have sought this index.
        /// </summary>
        field(8; "User Seeks"; BigInteger)
        {
        }
        /// <summary>
        /// The number of times user queries have scanned this table due to the missing index.
        /// </summary>
        field(9; "User Scans"; BigInteger)
        {
        }
        /// <summary>
        /// The average total cost for user queries that would benefit from this index.
        /// </summary>
        field(10; "Average Total User Cost"; Decimal)
        {
        }
        /// <summary>
        /// The average percentage improvement in query performance that this index would provide.
        /// </summary>
        field(11; "Average User Impact"; Decimal)
        {
        }
        /// <summary>
        /// The estimated benefit score for creating this index, calculated from usage and impact metrics.
        /// </summary>
        field(12; "Estimated Benefit"; Decimal)
        {
        }
    }
}