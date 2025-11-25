// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Tooling;

/// <summary>
/// Stores ordering definitions for designed queries, managing how query results are sorted.
/// </summary>
/// <remarks>
/// This table manages the sort order specifications for designed queries, defining which columns are used for ordering results.
/// Each record represents a specific sort criterion with direction (ascending/descending) and order priority.
/// Essential for creating queries that return data in a specific, predictable order for reporting and analysis.
/// </remarks>
table 2000000221 "Designed Query Order By"
{
    Caption = 'Designed Query Order By';
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
        /// The priority order of this sort criterion within the query's order by clause.
        /// </summary>
        field(2; "Order"; Integer)
        {
            Caption = 'Order';
        }
        /// <summary>
        /// The name of the column to be used for sorting the query results.
        /// </summary>
        field(3; "Column"; Text[120])
        {
            Caption = 'Column';
        }
        /// <summary>
        /// The sort direction for this column (ascending or descending).
        /// </summary>
        field(4; "Direction"; Option)
        {
            Caption = 'Direction';
            OptionCaption = 'Ascending,Descending';
            OptionMembers = "Ascending","Descending";
        }
    }

    keys
    {
        key(PK; "Query Id", "Order")
        {
            Clustered = true;
        }
    }
}