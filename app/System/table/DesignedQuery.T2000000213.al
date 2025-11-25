// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Tooling;

/// <summary>
/// Stores metadata for user-designed queries including their basic properties and configuration settings.
/// </summary>
/// <remarks>
/// This table serves as the main registry for designed queries created through the query designer interface.
/// It stores essential query metadata including names, descriptions, and row limits. Works in conjunction
/// with related tables for data items, columns, filters, and other query components to form a complete
/// query definition. Used by the query designer and runtime to manage custom query definitions created
/// by users within the Business Central environment.
/// </remarks>
table 2000000213 "Designed Query"
{
    Caption = 'Designed Query';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Unique auto-incrementing identifier for the designed query.
        /// </summary>
        field(1; "Query ID"; BigInteger)
        {
            Caption = 'Query ID';
            AutoIncrement = true;
        }
        /// <summary>
        /// Name of the designed query, must be unique across all queries.
        /// </summary>
        field(2; Name; Text[30])
        {
            Caption = 'Name';
        }
        /// <summary>
        /// Description of the query's purpose and functionality.
        /// </summary>
        field(3; Description; Text[250])
        {
            Caption = 'Description';
        }
        /// <summary>
        /// Maximum number of rows that this query should return to prevent performance issues.
        /// </summary>
        field(4; "Max Rows Included"; Integer)
        {
            Caption = 'Max Rows Included';
        }
    }

    keys
    {
        key(PK; "Query ID")
        {
            Clustered = true;
        }

        key("Name"; "Name")
        {
            Unique = true;
        }
    }
}