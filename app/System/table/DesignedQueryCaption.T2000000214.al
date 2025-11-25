// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Tooling;

/// <summary>
/// Stores localized captions for columns in designed queries, supporting multi-language display names.
/// </summary>
/// <remarks>
/// This table manages localized caption information for designed query columns, enabling multi-language support.
/// Each record represents a language-specific caption for a query column, allowing queries to display appropriate 
/// column headers based on the user's language preferences. Essential for internationalization of designed queries.
/// </remarks>
table 2000000214 "Designed Query Caption"
{
    Caption = 'Designed Query Caption';
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
        /// The name of the column that this caption applies to.
        /// </summary>
        field(2; "Column"; Text[120])
        {
            Caption = 'Column';
        }
        /// <summary>
        /// The language identifier for this localized caption.
        /// </summary>
        field(3; "Language ID"; Text[250])
        {
            Caption = 'Language ID';
        }
        /// <summary>
        /// The localized display name or caption for the column in the specified language.
        /// </summary>
        field(4; "Name"; Text[30])
        {
            Caption = 'Name';
        }
    }

    keys
    {
        key(PK; "Query Id", "Column", "Language ID")
        {
            Clustered = true;
        }
    }
}