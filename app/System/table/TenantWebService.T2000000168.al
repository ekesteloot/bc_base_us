// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Integration;

using System.Reflection;

/// <summary>
/// Stores web service endpoint configurations for exposing Business Central objects as OData or SOAP services.
/// Manages tenant-specific web service publishing settings and accessibility controls.
/// </summary>
/// <remarks>
/// This table enables external system integration by exposing pages, codeunits, and queries as web services.
/// Integrates with OData protocol, authentication mechanisms, and API versioning frameworks.
/// Used by integration management tools and external applications for data exchange and service consumption.
/// </remarks>
table 2000000168 "Tenant Web Service"
{
    Caption = 'Tenant Web Service';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// Type of Business Central object being exposed as a web service (Codeunit, Page, or Query).
        /// </summary>
        field(3; "Object Type"; Option)
        {
            Caption = 'Object Type';
            OptionMembers = ,,,,,"Codeunit",,,"Page","Query",,,,,,,,,,;
            OptionCaption = ',,,,,Codeunit,,,Page,Query,,,,,,,,,,';
        }
        /// <summary>
        /// Numeric identifier of the Business Central object being published as a web service.
        /// </summary>
        field(6; "Object ID"; Integer)
        {
            Caption = 'Object ID';
            TableRelation = AllObj."Object ID" WHERE("Object Type" = FIELD("Object Type"));
        }
        /// <summary>
        /// Public name of the web service endpoint for external consumption.
        /// </summary>
        field(9; "Service Name"; Text[250])
        {
            Caption = 'Service Name';
        }
        /// <summary>
        /// Indicates whether the web service is published and available for external access.
        /// </summary>
        field(12; Published; Boolean)
        {
            Caption = 'Published';
        }
        /// <summary>
        /// Controls whether fields outside repeaters are excluded from ETag calculations for optimistic concurrency.
        /// </summary>
        field(13; ExcludeFieldsOutsideRepeater; Boolean)
        {
            Caption = 'Exclude Fields Outside of the Repeater from Etag';
        }
        /// <summary>
        /// Controls whether non-editable flow fields are excluded from ETag calculations for performance optimization.
        /// </summary>
        field(14; ExcludeNonEditableFlowFields; Boolean)
        {
            Caption = 'Exclude Non-Editable Flow Fields from ETag';
        }
    }

    keys
    {
        key(Key1; "Object Type", "Service Name")
        {
            Clustered = true;
        }
        key(Key2; "Object Type", "Object ID")
        {
        }
    }

    fieldgroups
    {
    }
}

