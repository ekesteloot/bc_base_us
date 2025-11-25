// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment.Configuration;

/// <summary>
/// Stores database access intent overrides for specific objects, controlling read/write behavior for performance optimization.
/// </summary>
/// <remarks>
/// This table manages access intent configurations for reports, pages, and queries to optimize database performance.
/// Each record overrides the default access intent for a specific object, allowing fine-tuned control over read-only vs read-write operations.
/// Essential for performance optimization in cloud environments where read-only access can improve scalability and reduce locking.
/// </remarks>
table 2000000205 "Object Access Intent Override"
{
    Caption = 'Object Access Intent Override';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// The type of object that this access intent override applies to.
        /// </summary>
        field(1; "Object Type"; Option)
        {
            Caption = 'Object Type';
            OptionMembers = ,,,"Report",,,,,"Page","Query",,,,,,,,,,;
            OptionCaption = ',,,Report,,,,,Page,Query,,,,,,,,,,';
        }
        /// <summary>
        /// The unique identifier of the object that this access intent override applies to.
        /// </summary>
        field(2; "Object ID"; Integer)
        {
            Caption = 'Object ID';
        }
        /// <summary>
        /// The database access intent override setting for the specified object.
        /// </summary>
        field(3; "Access Intent"; Option)
        {
            Caption = 'Access Intent';
            OptionCaption = 'Default,ReadOnly,ReadWrite';
            OptionMembers = Default,ReadOnly,ReadWrite;
        }
    }

    keys
    {
        key(Key1; "Object Type", "Object ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

