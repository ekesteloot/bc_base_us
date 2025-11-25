// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Tooling;

/// <summary>
/// Stores category assignments for designed queries, enabling query organization and classification.
/// </summary>
/// <remarks>
/// This table manages the categorization of designed queries, allowing queries to be grouped and organized by category.
/// Each record represents a category assignment for a query, supporting multiple categories per query through ordering.
/// Essential for query discovery, organization, and management within the designed query framework.
/// </remarks>
table 2000000215 "Designed Query Category"
{
    Caption = 'Designed Query Category';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// The unique identifier of the designed query being categorized.
        /// </summary>
        field(1; "Query ID"; BigInteger)
        {
            Caption = 'Query ID';
        }
        /// <summary>
        /// The order position of this category assignment for the query.
        /// </summary>
        field(2; "Order"; Integer)
        {
            Caption = 'Order';
        }
        /// <summary>
        /// The name of the category assigned to the query.
        /// </summary>
        field(3; "Category"; Text[30])
        {
            Caption = 'Category';
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