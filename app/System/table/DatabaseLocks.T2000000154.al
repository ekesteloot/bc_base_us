// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Diagnostics;

/// <summary>
/// Virtual table that provides real-time information about database locks and blocking transactions.
/// This table enables monitoring of database contention and identifying performance bottlenecks.
/// </summary>
/// <remarks>
/// The Database Locks table is essential for database performance monitoring and troubleshooting
/// concurrency issues in Business Central. It provides real-time visibility into active database
/// locks, their types, status, and the AL objects and users involved. This information is crucial
/// for identifying blocking scenarios, deadlock situations, and performance problems caused by
/// lock contention. The table helps administrators and developers understand transaction behavior,
/// optimize concurrency patterns, and resolve blocking issues that can impact system performance.
/// This diagnostic information is vital for maintaining optimal database performance in production environments.
/// </remarks>
table 2000000154 "Database Locks"
{
    DataPerCompany = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// The unique identifier of the database transaction holding or requesting the lock.
        /// </summary>
        field(1; "Transaction ID"; BigInteger)
        {
        }
        /// <summary>
        /// The name of the database object (table, index, etc.) that is locked.
        /// </summary>
        field(2; "Object Name"; Text[250])
        {
        }
        /// <summary>
        /// The type of database resource that is locked (table, page, row, etc.).
        /// </summary>
        field(3; "Resource Type"; Text[60])
        {
        }
        /// <summary>
        /// The mode of the lock request (Shared, Update, Exclusive, etc.).
        /// </summary>
        field(4; "Request Mode"; Option)
        {
            OptionMembers = Shared,Update,Exclusive,"Bulk Update",Unknown;
        }
        /// <summary>
        /// The current status of the lock request (Granted, Converting, Waiting, etc.).
        /// </summary>
        field(5; "Request Status"; Option)
        {
            OptionMembers = Granted,Converting,Waiting,Unknown;
        }
        /// <summary>
        /// The name of the user whose session is involved in the lock.
        /// </summary>
        field(6; "User Name"; Text[250])
        {
        }
        /// <summary>
        /// The type of AL object that initiated the database operation causing the lock.
        /// </summary>
        field(7; "AL Object Type"; option)
        {
            OptionMembers = TableData,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,System,FieldNumber;
        }
        /// <summary>
        /// The ID of the AL object that initiated the database operation causing the lock.
        /// </summary>
        field(8; "AL Object Id"; Integer)
        {
        }
        /// <summary>
        /// The specific method or scope within the AL object where the lock was initiated.
        /// </summary>
        field(9; "AL Method Scope"; Text[250])
        {
        }
        /// <summary>
        /// The SQL Server session identifier associated with the lock.
        /// </summary>
        field(10; "SQL Session ID"; Integer)
        {
        }
        /// <summary>
        /// The Business Central session identifier associated with the lock.
        /// </summary>
        field(11; "Session ID"; Integer)
        {
        }
        /// <summary>
        /// The name of the AL object that initiated the database operation causing the lock.
        /// </summary>
        field(12; "AL Object Name"; Text[250])
        {
        }
        /// <summary>
        /// The name of the AL object extension if the lock was initiated from an extension object.
        /// </summary>
        field(13; "AL Object Extension Name"; Text[250])
        {
        }
    }
}