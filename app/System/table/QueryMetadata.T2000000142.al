// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Reflection;

/// <summary>
/// Virtual table that provides metadata information about all queries in the system.
/// This table enables introspection of query properties, API configurations, and data access characteristics.
/// </summary>
/// <remarks>
/// The Query Metadata table is essential for understanding query definitions and their capabilities.
/// It includes detailed information about query structures, API exposure settings, permissions,
/// and categorization. This table is crucial for query management tools, API configuration,
/// data access monitoring, and administrative utilities that need to understand query behaviors
/// and constraints. The information covers all query types including those exposed as APIs,
/// providing visibility into the data query infrastructure across all applications.
/// Queries are fundamental for data aggregation, reporting, and API-based data access scenarios.
/// </remarks>
table 2000000142 "Query Metadata"
{
    DataPerCompany = False;
    Scope = Cloud;
    InherentPermissions = rX;

    fields
    {
        /// <summary>
        /// The unique identifier number of the query.
        /// </summary>
        field(1; ID; Integer)
        {
        }
        /// <summary>
        /// The name of the query as defined in the AL source code.
        /// </summary>
        field(2; Name; Text[30])
        {
        }
        /// <summary>
        /// The caption text displayed for this query in the user interface.
        /// </summary>
        field(3; Caption; Text[80])
        {
        }
        /// <summary>
        /// The publisher name for API queries when exposed through web services.
        /// </summary>
        field(4; APIPublisher; Text[40])
        {
        }
        /// <summary>
        /// The API group classification for API queries.
        /// </summary>
        field(5; APIGroup; Text[40])
        {
        }
        /// <summary>
        /// The API version identifier for API queries.
        /// </summary>
        field(6; APIVersion; Text[250])
        {
        }
        /// <summary>
        /// The entity set name used in OData APIs for this query.
        /// </summary>
        field(7; EntitySetName; Text[250])
        {
        }
        /// <summary>
        /// The entity name used in OData APIs for this query.
        /// </summary>
        field(8; EntityName; Text[250])
        {
        }
        /// <summary>
        /// The category classification for organizing and grouping related queries.
        /// </summary>
        field(9; Category; Text[250])
        {
        }
        /// <summary>
        /// The application identifier that contains this query.
        /// </summary>
        field(10; "App ID"; Guid)
        {
        }
        /// <summary>
        /// The inherent permissions defined for this query (Read, Insert, Modify, Delete).
        /// </summary>
        field(11; InherentPermissions; Text[5])
        {
        }
        /// <summary>
        /// The inherent entitlements required to access this query.
        /// </summary>
        field(12; InherentEntitlements; Text[5])
        {
        }
    }

    keys
    {
        key(pk; ID)
        {

        }
    }

    fieldgroups
    {
        fieldgroup("DropDown"; ID, Caption)
        {
        }
    }
}