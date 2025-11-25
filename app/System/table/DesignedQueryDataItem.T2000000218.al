// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Tooling;

/// <summary>
/// Stores data item definitions for designed queries, representing the data sources and structure used in query objects.
/// </summary>
/// <remarks>
/// This table manages the data items (tables, views, or other data sources) that are part of designed queries.
/// Each record represents a specific data source within a query, including its name, description, table relation, and ordering.
/// Essential for the designed query framework, enabling dynamic query building and data source management.
/// </remarks>
table 2000000218 "Designed Query Data Item"
{
    Caption = 'Designed Query Data Item';
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
        /// The order position of this data item within the query structure.
        /// </summary>
        field(2; "Order"; Integer)
        {
            Caption = 'Order';
        }
        /// <summary>
        /// The name identifier for this data item within the query.
        /// </summary>
        field(3; "Name"; Text[120])
        {
            Caption = 'Name';
        }
        /// <summary>
        /// A descriptive text explaining the purpose or content of this data item.
        /// </summary>
        field(4; "Description"; Text[250])
        {
            Caption = 'Description';
        }
        /// <summary>
        /// The reference to the source table or object that this data item represents.
        /// </summary>
        field(5; "Source Reference"; Text[30])
        {
            Caption = 'Source Reference';
        }
        /// <summary>
        /// The type of join operation to use when connecting this data item to other data items in the query.
        /// </summary>
        field(6; "Join Type"; Option)
        {
            Caption = 'Join Type';
            OptionCaption = 'Inner,LeftOuter,RightOuter,FullOuter';
            OptionMembers = Inner,LeftOuter,RightOuter,FullOuter;
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