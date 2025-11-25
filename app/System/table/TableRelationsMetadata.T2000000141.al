// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Reflection;

/// <summary>
/// Virtual table that exposes metadata about table relationships defined in the system.
/// </summary>
/// <remarks>
/// This table provides detailed information about field relationships between tables, including foreign key constraints,
/// conditions, and validation settings. Essential for understanding database schema relationships and building
/// dynamic data integrity validations. Used by tools that need to analyze or validate table relationships programmatically.
/// The table is not per-company and provides read-only access to relationship metadata across all tables in the system.
/// </remarks>
table 2000000141 "Table Relations Metadata"
{
    DataPerCompany = False;
    Scope = Cloud;
    InherentPermissions = rX;

    fields
    {
        /// <summary>
        /// The ID of the source table that contains the field with the relationship.
        /// </summary>
        field(1; "Table ID"; Integer)
        {
        }
        /// <summary>
        /// The field number in the source table that has the relationship definition.
        /// </summary>
        field(2; "Field No."; Integer)
        {
        }
        /// <summary>
        /// The sequence number of the relationship when multiple relationships exist for the same field.
        /// </summary>
        field(3; "Relation No."; Integer)
        {
        }
        /// <summary>
        /// The sequence number of the condition when multiple conditions exist for the same relationship.
        /// </summary>
        field(4; "Condition No."; Integer)
        {
        }
        /// <summary>
        /// The ID of the target table that the field relates to.
        /// </summary>
        field(5; "Related Table ID"; Integer)
        {
        }
        /// <summary>
        /// The field number in the related table that this field references.
        /// </summary>
        field(6; "Related Field No."; Integer)
        {
        }
        /// <summary>
        /// The type of condition applied to this table relationship (CONST or FILTER).
        /// </summary>
        field(7; "Condition Type"; Option)
        {
            OptionMembers = "CONST","FILTER";
        }
        /// <summary>
        /// The field number used in the relationship condition.
        /// </summary>
        field(8; "Condition Field No."; Integer)
        {
        }
        /// <summary>
        /// The value used in the relationship condition when condition type is CONST.
        /// </summary>
        field(9; "Condition Value"; Text[30])
        {
        }
        /// <summary>
        /// Indicates whether the table relation should be tested for validity.
        /// </summary>
        field(10; "Test Table Relation"; Boolean)
        {
        }
        /// <summary>
        /// Indicates whether the table relation should be validated during data entry.
        /// </summary>
        field(11; "Validate Table Relation"; Boolean)
        {
        }
        /// <summary>
        /// The name of the source table.
        /// </summary>
        field(12; "Table Name"; Text[30])
        {
        }
        /// <summary>
        /// The name of the field in the source table.
        /// </summary>
        field(13; "Field Name"; Text[30])
        {
        }
        /// <summary>
        /// The name of the related target table.
        /// </summary>
        field(14; "Related Table Name"; Text[30])
        {
        }
        /// <summary>
        /// The name of the field in the related table.
        /// </summary>
        field(15; "Related Field Name"; Text[30])
        {
        }
    }
    keys
    {
        key(pk; "Table ID", "Field No.", "Relation No.", "Condition No.")
        {

        }
    }
}