// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Tooling;

/// <summary>
/// Stores grouping definitions for designed queries, managing how query results are grouped by specific fields or expressions.
/// </summary>
/// <remarks>
/// This table manages the grouping specifications for designed queries, defining which fields or expressions are used to group query results.
/// Each record represents a group-by clause in the query, enabling data aggregation and organized result presentation.
/// Essential for creating queries that need to aggregate or organize data by specific criteria.
/// </remarks>
table 2000000224 "Designed Query Group"
{
    Caption = 'Designed Query Group';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// The unique identifier of the parent designed query.
        /// </summary>
        field(1; "Query ID"; BigInteger)
        {
            Caption = 'Query ID';
        }
        /// <summary>
        /// The field or expression that the query results should be grouped by.
        /// </summary>
        field(2; "Group"; Text[100])
        {
            Caption = 'Group';
        }
    }

    keys
    {
        key(PK; "Query Id", "Group")
        {
            Clustered = true;
        }
    }
}