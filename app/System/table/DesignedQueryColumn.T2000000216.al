// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Tooling;

/// <summary>
/// Defines column specifications for designed queries, including data sources, aggregation methods, and display properties.
/// </summary>
/// <remarks>
/// This table stores the column definitions for user-designed queries, specifying which data fields should be included
/// in query results and how they should be processed. Supports various column types including normal data fields,
/// aggregating columns with mathematical operations, and count columns. Each column can be configured with specific
/// aggregation methods, ordering, and formatting options. Used by the query designer to build dynamic query
/// structures and by the query runtime to generate appropriate SQL statements.
/// </remarks>
table 2000000216 "Designed Query Column"
{
    Caption = 'Designed Query Column';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Identifier of the designed query this column belongs to.
        /// </summary>
        field(1; "Query ID"; BigInteger)
        {
            Caption = 'Query ID';
        }
        /// <summary>
        /// Name of the data item (table or data source) this column references.
        /// </summary>
        field(2; "Data Item"; Text[120])
        {
            Caption = 'Data Item';
        }
        /// <summary>
        /// Display order of this column in the query results.
        /// </summary>
        field(3; "Order"; Integer)
        {
            Caption = 'Order';
        }
        /// <summary>
        /// Name of the column as it will appear in query results.
        /// </summary>
        field(4; "Name"; Text[120])
        {
            Caption = 'Name';
        }
        /// <summary>
        /// Description of the column's purpose and content.
        /// </summary>
        field(5; "Description"; Text[250])
        {
            Caption = 'Description';
        }
        /// <summary>
        /// Reference to the source field or expression for this column.
        /// </summary>
        field(6; "Source Reference"; Text[30])
        {
            Caption = 'Source Reference';
        }
        /// <summary>
        /// Type of column defining how data is processed (Normal, Aggregating, Count).
        /// </summary>
        field(7; "Column Type"; Option)
        {
            Caption = 'Column Type';
            OptionCaption = 'Normal,Aggregating,Count';
            OptionMembers = Normal,Aggregating,Count;
        }
        /// <summary>
        /// Aggregation method applied to the column data for grouping and calculations.
        /// </summary>
        field(8; "Method"; Option)
        {
            Caption = 'Method';
            OptionCaption = 'Average,Count,Max,Min,Sum,Year,Month,Day';
            OptionMembers = Average,Count,Max,Min,Sum,Year,Month,Day;
        }
        /// <summary>
        /// Indicates whether to invert the sign of numeric values in this column.
        /// </summary>
        field(9; "Invert Sign"; Boolean)
        {
            Caption = 'Invert Sign';
        }
    }

    keys
    {
        key(PK; "Query Id", "Data Item", "Order")
        {
            Clustered = true;
        }
    }
}