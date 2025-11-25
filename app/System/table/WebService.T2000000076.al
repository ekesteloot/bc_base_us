// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Integration;

using System.Reflection;

/// <summary>
/// Manages web service endpoint configurations for exposing Business Central objects as REST and SOAP services.
/// Controls publishing settings, security options, and ETag handling for external API access.
/// </summary>
/// <remarks>
/// This table configures web service endpoints enabling external systems to access Business Central functionality through REST and SOAP protocols. Manages service publishing state, endpoint naming, and optimization settings for entity tag handling. Used by the web service infrastructure for endpoint discovery and configuration management.
/// </remarks>
table 2000000076 "Web Service"
{
    Caption = 'Web Service';
    DataPerCompany = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Type of Business Central object being exposed as a web service.
        /// </summary>
        field(3; "Object Type"; Option)
        {
            Caption = 'Object Type';
            OptionMembers = ,,,,,"Codeunit",,,"Page","Query",,,,,,,,,,;
            OptionCaption = ',,,,,Codeunit,,,Page,Query,,,,,,,,,,';
        }
        /// <summary>
        /// Unique identifier of the Business Central object being exposed as a web service.
        /// </summary>
        field(6; "Object ID"; Integer)
        {
            Caption = 'Object ID';
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = FIELD("Object Type"));
        }
        /// <summary>
        /// Public name for the web service endpoint used in URL generation and API documentation.
        /// </summary>
        field(9; "Service Name"; Text[250])
        {
            Caption = 'Service Name';
        }
        /// <summary>
        /// Indicates whether the web service is actively published and available for external consumption.
        /// </summary>
        field(12; Published; Boolean)
        {
            Caption = 'Published';
        }
        /// <summary>
        /// Controls whether fields outside repeater controls are excluded from ETag calculation for optimistic concurrency.
        /// </summary>
        field(13; ExcludeFieldsOutsideRepeater; Boolean)
        {
            Caption = 'Exclude Fields Outside of the Repeater from ETag';
        }
        /// <summary>
        /// Controls whether non-editable flow fields are excluded from ETag calculation to optimize concurrency handling.
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

