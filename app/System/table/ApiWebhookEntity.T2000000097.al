// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Integration;

using System.Reflection;

/// <summary>
/// Virtual table that provides metadata about API webhook entities available in the system.
/// </summary>
/// <remarks>
/// This table exposes information about API entities that can be used for webhook integrations,
/// including their structure, associated tables, and OData configuration. Essential for API
/// discovery, webhook configuration, and integration development. Used by the platform to
/// manage webhook subscriptions and by developers to understand available API endpoints
/// for webhook scenarios. The table includes versioning and grouping information for
/// API entity management.
/// </remarks>
table 2000000097 "API Webhook Entity"
{
    Caption = 'API Webhook Entity';
    DataPerCompany = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// The publisher name of the API that provides this webhook entity.
        /// </summary>
        field(1; Publisher; Text[40])
        {
        }

        /// <summary>
        /// The group classification of the API webhook entity.
        /// </summary>
        field(2; "Group"; Text[40])
        {
        }

        /// <summary>
        /// The version of the API that this webhook entity belongs to.
        /// </summary>
        field(3; "Version"; Text[10])
        {
        }

        /// <summary>
        /// The name of the webhook entity as exposed in the API.
        /// </summary>
        field(4; Name; Text[250])
        {
        }

        /// <summary>
        /// The number of the table that underlies this webhook entity.
        /// </summary>
        field(5; "Table No."; Integer)
        {
        }

        /// <summary>
        /// Indicates whether the underlying table is a temporary table.
        /// </summary>
        field(6; "Table Temporary"; Boolean)
        {
        }

        /// <summary>
        /// The filters applied to the underlying table for this webhook entity.
        /// </summary>
        field(7; "Table Filters"; Blob)
        {
        }

        /// <summary>
        /// The key fields that uniquely identify records in this webhook entity.
        /// </summary>
        field(8; "Key Fields"; Text[250])
        {
        }

        /// <summary>
        /// Indicates whether an OData key has been explicitly specified for this entity.
        /// </summary>
        field(9; "OData Key Specified"; Boolean)
        {
        }

        /// <summary>
        /// The type of AL object that implements this webhook entity (Codeunit, Page, or Query).
        /// </summary>
        field(10; "Object Type"; Option)
        {
            OptionMembers = ,,,,,"Codeunit",,,"Page","Query",,,,,,,,,,;
            OptionCaption = ',,,,,Codeunit,,,Page,Query,,,,,,,,,,';
        }

        /// <summary>
        /// The ID of the AL object that implements this webhook entity.
        /// </summary>
        field(11; "Object ID"; Integer)
        {
            TableRelation = AllObj."Object ID" where("Object Type" = field("Object Type"));
        }

        /// <summary>
        /// The package ID that contains the implementation of this webhook entity.
        /// </summary>
        field(12; "Package ID"; Guid)
        {
        }
    }

    keys
    {
        key(Key1; Publisher, "Group", "Version", Name)
        {
            Clustered = true;
        }

        key(Key2; "Object Type", "Object ID")
        {
        }

        key(Key3; "Package ID")
        {
        }
    }
}

