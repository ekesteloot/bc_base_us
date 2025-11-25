// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Diagnostics;

/// <summary>
/// Virtual table that provides database wait statistics for performance monitoring and analysis.
/// </summary>
/// <remarks>
/// This table exposes database engine wait statistics that are crucial for diagnosing performance issues
/// and understanding database workload patterns. Essential for database administrators and performance
/// analysts to identify bottlenecks, resource contention, and optimization opportunities. The statistics
/// are categorized by wait types and include timing information to help prioritize performance tuning efforts.
/// Available in Cloud scope for database performance monitoring.
/// </remarks>
table 2000000235 "Database Wait Statistics"
{
    DataPerCompany = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// The category or type of database wait being measured.
        /// </summary>
        field(1; "Wait Category"; Text[60])
        {
        }
        /// <summary>
        /// The total number of tasks that have waited for this wait category.
        /// </summary>
        field(2; "Waiting Tasks Count"; BigInteger)
        {
        }
        /// <summary>
        /// The total cumulative wait time for this category, measured in milliseconds.
        /// </summary>
        field(3; "Wait Time in ms"; BigInteger)
        {
        }
        /// <summary>
        /// The maximum single wait time recorded for this category, measured in milliseconds.
        /// </summary>
        field(4; "Max Wait Time in ms"; BigInteger)
        {
        }
        /// <summary>
        /// The time spent in signal waits for this category, measured in milliseconds.
        /// </summary>
        field(5; "Signal Wait Time in ms"; BigInteger)
        {
        }
        /// <summary>
        /// The timestamp when the database was started, providing context for the statistics collection period.
        /// </summary>
        field(6; "Database start time"; Datetime)
        {
        }

    }
}