// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Tooling;

/// <summary>
/// Virtual table containing information about designed query objects in the system.
/// Provides metadata about queries that have been designed and registered for execution.
/// </summary>
/// <remarks>
/// This table enables query management, execution tracking, and design-time tooling support.
/// Used by development tools and runtime systems to identify and manage designed queries.
/// Supports query lookup by ID, name, and unique identifiers for cross-referencing purposes.
/// </remarks>
table 2000000223 "Designed Query Obj"
{
    DataPerCompany = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Numeric identifier of the designed query object.
        /// </summary>
        field(1; "Object ID"; Integer)
        {
        }
        /// <summary>
        /// Name of the designed query object.
        /// </summary>
        field(2; "Object Name"; Text[30])
        {
        }
        /// <summary>
        /// Global unique identifier for the designed query instance.
        /// </summary>
        field(3; "Unique ID"; Guid)
        {
        }
        /// <summary>
        /// Runtime identifier assigned to the query during execution.
        /// </summary>
        field(4; "Query ID"; BigInteger)
        {
        }
    }

    keys
    {
        key(PK; "Object ID")
        {
        }
    }
    fieldGroups
    {
        fieldgroup("DropDown"; "Object ID", "Object Name")
        {
        }
    }
}