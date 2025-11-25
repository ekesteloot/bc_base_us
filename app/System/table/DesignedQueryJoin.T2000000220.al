// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Tooling;

/// <summary>
/// Stores join definitions for designed queries, managing relationships between data items in query structures.
/// </summary>
/// <remarks>
/// This table manages the join conditions between different data items within designed queries.
/// Each record represents a specific join relationship, defining how tables are connected through field relationships.
/// Essential for creating complex queries that span multiple tables with proper data relationships.
/// </remarks>
table 2000000220 "Designed Query Join"
{
    Caption = 'Designed Query Join';
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
        /// The name of the inner data item in the join relationship.
        /// </summary>
        field(2; "Inner Data Item"; Text[120])
        {
            Caption = 'Inner Data Item';
        }
        /// <summary>
        /// The order position of this join condition within the query structure.
        /// </summary>
        field(3; "Order"; Integer)
        {
            Caption = 'Order';
        }
        /// <summary>
        /// The field name from the inner data item used in the join condition.
        /// </summary>
        field(4; "Inner Field"; Text[30])
        {
            Caption = 'Inner Field';
        }
        /// <summary>
        /// The name of the outer data item in the join relationship.
        /// </summary>
        field(5; "Outer Data Item"; Text[120])
        {
            Caption = 'Outer Data Item';
        }
        /// <summary>
        /// The field name from the outer data item used in the join condition.
        /// </summary>
        field(6; "Outer Field"; Text[30])
        {
            Caption = 'Outer Field';
        }
    }

    keys
    {
        key(PK; "Query Id", "Inner Data Item", "Order")
        {
            Clustered = true;
        }
    }
}