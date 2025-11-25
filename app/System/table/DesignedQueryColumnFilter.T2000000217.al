// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Tooling;

/// <summary>
/// Stores column-specific filter definitions for designed queries, managing filters applied to individual query columns.
/// </summary>
/// <remarks>
/// This table manages filters that are specifically applied to individual columns within designed queries.
/// Each record represents a filter condition on a specific column, including comparison operators, values, and logical expressions.
/// Essential for providing column-level filtering capabilities in the designed query framework.
/// </remarks>
table 2000000217 "Designed Query Column Filter"
{
    Caption = 'Designed Query Column Filter';
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
        /// The name of the column that this filter applies to.
        /// </summary>
        field(2; "Column"; Text[120])
        {
            Caption = 'Column';
        }
        /// <summary>
        /// The order position of this filter within the column's filter chain.
        /// </summary>
        field(3; "Order"; Integer)
        {
            Caption = 'Order';
        }
        /// <summary>
        /// The type of comparison or operation to perform in this column filter.
        /// </summary>
        field(4; "Filter Type"; Option)
        {
            Caption = 'Filter Type';
            OptionCaption = 'Equal,NotEqual,GreaterThan,GreaterThanEqual,LessThan,LessThanEqual,Contains';
            OptionMembers = Equal,NotEqual,GreaterThan,GreaterThanEqual,LessThan,LessThanEqual,Contains;
        }
        /// <summary>
        /// The value that the column is compared to in the filter.
        /// </summary>
        field(5; "Value"; Text[2048])
        {
            Caption = 'Value';
        }
        /// <summary>
        /// Indicates whether the filter should ignore case sensitivity when comparing text values.
        /// </summary>
        field(6; "Ignore Case"; Boolean)
        {
            Caption = 'Ignore Case';
        }
        /// <summary>
        /// The type of expression used in the filter, either a simple filter or a logical expression.
        /// </summary>
        field(7; "Filter Expression Type"; Option)
        {
            Caption = 'Filter Expression Type';
            OptionCaption = 'Filter,Logical';
            OptionMembers = Filter,Logical;
        }
        /// <summary>
        /// The number of operands used in the filter expression.
        /// </summary>
        field(8; "Operand Count"; Integer)
        {
            Caption = 'Operand Count';
        }
    }

    keys
    {
        key(PK; "Query Id", "Column", "Order")
        {
            Clustered = true;
        }
    }
}