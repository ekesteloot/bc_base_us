// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Tooling;

/// <summary>
/// Virtual table providing management and organizational information for designed queries.
/// Enables categorization, grouping, and administrative control over query objects in the system.
/// </summary>
/// <remarks>
/// This table extends the basic query object information with management capabilities including
/// grouping, categorization, and descriptive metadata. Used by administrative tools and query
/// management interfaces to organize and present queries in a structured manner.
/// </remarks>
table 2000000225 "Designed Query Management"
{
    DataPerCompany = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Numeric identifier of the query object being managed.
        /// </summary>
        field(1; "Object ID"; Integer)
        {
            Caption = 'Object ID';
            Editable = false;
        }
        /// <summary>
        /// Name of the query object being managed.
        /// </summary>
        field(2; "Object Name"; Text[30])
        {
            Caption = 'Object Name';
            Editable = false;
        }
        /// <summary>
        /// Global unique identifier for the query instance.
        /// </summary>
        field(3; "Unique ID"; Guid)
        {
            Caption = 'Unique ID';
            Editable = false;
        }
        /// <summary>
        /// Runtime identifier assigned to the query during execution.
        /// </summary>
        field(4; "Query ID"; BigInteger)
        {
            Caption = 'Query ID';
            Editable = false;
        }
        /// <summary>
        /// Descriptive text explaining the purpose and functionality of the query.
        /// </summary>
        field(5; "Description"; Text[250])
        {
            Caption = 'Description';
            Editable = false;
        }
        /// <summary>
        /// Organizational group classification for the query, allowing custom grouping.
        /// </summary>
        field(6; "Group"; Text[100])
        {
            Caption = 'Group';
            Editable = true;
        }
        /// <summary>
        /// Category classifications assigned to the query for organizational purposes.
        /// </summary>
        field(7; "Categories"; Text[250])
        {
            Caption = 'Category';
            Editable = false;
        }
        /// <summary>
        /// Name of the primary source table that the query operates on.
        /// </summary>
        field(8; "Primary Source Table"; Text[30])
        {
            Caption = 'Category';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Object ID")
        {
        }
    }
}