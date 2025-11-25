// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Tooling;

/// <summary>
/// Stores navigation definitions that link query results to related pages, enabling drill-down functionality.
/// </summary>
/// <remarks>
/// This table manages navigation links between query objects and target pages, defining how users can navigate from query results to detailed records.
/// Each record represents a specific navigation path with linking criteria and target page information.
/// Essential for creating interactive query experiences with drill-through capabilities in reporting and analytics scenarios.
/// </remarks>
table 2000000226 "Query Navigation"
{
    Caption = 'Query Navigation';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// The unique identifier for this query navigation definition.
        /// </summary>
        field(1; "Id"; BigInteger)
        {
            Caption = 'Id';
            AutoIncrement = true;
        }
        /// <summary>
        /// The name of this navigation definition.
        /// </summary>
        field(2; Name; Text[250])
        {
            Caption = 'Name';
        }
        /// <summary>
        /// Indicates whether this is the default navigation for the source query.
        /// </summary>
        field(3; "Default"; Boolean)
        {
            Caption = 'Default';
        }
        /// <summary>
        /// The identifier of the source query object that provides the navigation starting point.
        /// </summary>
        field(4; "Source Query Object Id"; Integer)
        {
            Caption = 'Source Query Object Id';
        }
        /// <summary>
        /// The identifier of the target page that users navigate to from the query results.
        /// </summary>
        field(5; "Target Page Id"; Integer)
        {
            Caption = 'Target Page Id';
        }
        /// <summary>
        /// The name of the data item that provides the linking criteria between query and target page.
        /// </summary>
        field(6; "Linking Data Item Name"; Text[250])
        {
            Caption = 'Linking Data Item Name';
        }
    }

    keys
    {
        key(PK; "Id")
        {
            Clustered = true;
        }

        key(QueryLookupKey; "Source Query Object Id")
        {
        }
    }
}