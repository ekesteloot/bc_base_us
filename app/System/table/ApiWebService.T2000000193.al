// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Integration;

/// <summary>
/// Virtual table that provides information about API web services exposed by the Business Central system.
/// This table enables discovery and management of published API endpoints and their configurations.
/// </summary>
/// <remarks>
/// The API Web Service table is essential for API management and integration scenarios in Business Central.
/// It provides information about all API endpoints exposed by pages, queries, and codeunits,
/// including their publication status, versioning, and organizational details. This table is crucial for
/// API governance, endpoint discovery, and integration management. It helps administrators and developers
/// understand what APIs are available, their characteristics, and how they're organized by publisher,
/// group, and version. The information supports API lifecycle management, integration planning, and
/// ensuring proper API exposure for external systems and applications.
/// </remarks>
table 2000000193 "Api Web Service"
{
    Caption = 'Api Web Service';
    DataPerCompany = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// The type of AL object that exposes the API (Codeunit, Page, or Query).
        /// </summary>
        field(3; "Object Type"; Option)
        {
            Caption = 'Object Type';
            OptionMembers = ,,,,,"Codeunit",,,"Page","Query",,,,,,,,,,;
            OptionCaption = ',,,,,Codeunit,,,Page,Query,,,,,,,,,,';
        }
        /// <summary>
        /// The unique identifier of the AL object that exposes the API.
        /// </summary>
        field(6; "Object ID"; Integer)
        {
            Caption = 'Object ID';
        }
        /// <summary>
        /// The name of the web service as exposed in the API endpoint.
        /// </summary>
        field(9; "Service Name"; Text[250])
        {
            Caption = 'Service Name';
        }
        /// <summary>
        /// Indicates whether the API web service is currently published and available for external access.
        /// </summary>
        field(12; Published; Boolean)
        {
            Caption = 'Published';
        }
        /// <summary>
        /// The publisher name associated with the API for organizational and branding purposes.
        /// </summary>
        field(14; Publisher; Text[40])
        {
            Caption = 'Publisher';
        }
        /// <summary>
        /// The group classification used to organize related APIs together.
        /// </summary>
        field(15; Group; Text[40])
        {
            Caption = 'Group';
        }
        /// <summary>
        /// The version identifier of the API used for API versioning and backward compatibility.
        /// </summary>
        field(18; Version; Text[10])
        {
            Caption = 'Version';
        }
        /// <summary>
        /// The package identifier of the application that contains the API web service.
        /// </summary>
        field(21; "Package ID"; GUID)
        {
            Caption = 'Package ID';
        }
    }

    keys
    {
        key(pk; "Object Type", "Object ID", "Service Name", Publisher, Group, Version, "Package ID")
        {
        }
    }
}