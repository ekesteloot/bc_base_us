// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Tooling;

/// <summary>
/// Stores filter definitions for designed queries, managing criteria and conditions applied to query data items.
/// </summary>
/// <remarks>
/// This table manages the filter conditions applied to data items within designed queries.
/// Each record represents a specific filter criterion, including the field being filtered, filter type, value, and logical operators.
/// Essential for the designed query framework to support dynamic filtering and data selection criteria.
/// </remarks>
table 2000000219 "Designed Query Filter"
{
    Caption = 'Designed Query Filter';
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
        /// The name of the data item that this filter applies to.
        /// </summary>
        field(2; "Data Item"; Text[120])
        {
            Caption = 'Data Item';
        }
        /// <summary>
        /// The reference to the specific field or source being filtered.
        /// </summary>
        field(3; "Source Reference"; Text[120])
        {
            Caption = 'Source Reference';
        }
        /// <summary>
        /// The order position of this filter within the filter chain.
        /// </summary>
        field(4; "Order"; Integer)
        {
            Caption = 'Order';
        }
        /// <summary>
        /// The type of comparison or operation to perform in this filter.
        /// </summary>
        field(5; "Filter Type"; Option)
        {
            Caption = 'Filter Type';
            OptionCaption = 'Equal,NotEqual,GreaterThan,GreaterThanEqual,LessThan,LessThanEqual,Contains';
            OptionMembers = Equal,NotEqual,GreaterThan,GreaterThanEqual,LessThan,LessThanEqual,Contains;
        }
        /// <summary>
        /// The value that the data item is compared to in the filter.
        /// </summary>
        field(6; "Value"; Text[2048])
        {
            Caption = 'Value';
        }
        /// <summary>
        /// Indicates whether the filter should ignore case sensitivity.
        /// </summary>
        field(7; "Ignore Case"; Boolean)
        {
            Caption = 'Ignore Case';
        }
        /// <summary>
        /// The type of expression used in the filter, either a simple filter or a logical expression.
        /// </summary>
        field(8; "Filter Expression Type"; Option)
        {
            Caption = 'Filter Expression Type';
            OptionCaption = 'Filter,Logical';
            OptionMembers = Filter,Logical;
        }
        /// <summary>
        /// The number of operands used in the filter expression.
        /// </summary>
        field(9; "Operand Count"; Integer)
        {
            Caption = 'Operand Count';
        }
    }

    keys
    {
        key(PK; "Query Id", "Data Item", "Source Reference", "Order")
        {
            Clustered = true;
        }
    }
}