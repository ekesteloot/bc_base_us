// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment.Configuration;

using System.Reflection;

/// <summary>
/// Contains the page customizations created using the in-client profile configuration.
/// </summary>
/// <remarks>
/// Pages customizations for profiles from extensions are stored as resources in the [Application Resource] table.
/// </remarks>
table 2000000187 "Tenant Profile Page Metadata"
{
    Caption = 'Tenant Profile Page Metadata';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;
    InherentPermissions = rX;

    fields
    {
        /// <summary>
        /// Application identifier that owns the profile for which page customizations are defined.
        /// </summary>
        field(1; "App ID"; Guid)
        {
            Caption = 'App ID';
        }
        /// <summary>
        /// Identifier of the profile that contains the page customizations, linking to tenant profile definitions.
        /// </summary>
        field(2; "Profile ID"; Code[30])
        {
            Caption = 'Profile ID';
            TableRelation = "Tenant Profile"."Profile ID";
        }
        /// <summary>
        /// Unique identifier of the page object that has been customized within the profile configuration.
        /// </summary>
        field(3; "Page ID"; Integer)
        {
            Caption = 'Page ID';
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Page));
        }
        /// <summary>
        /// Binary metadata containing the page customization configuration data created through in-client profile designer.
        /// </summary>
        field(4; "Page Metadata"; BLOB)
        {
            Caption = 'Page Metadata';
        }
        /// <summary>
        /// Generated AL code representing the page customizations, stored as binary data for compilation and execution.
        /// </summary>
        field(5; "Page AL"; BLOB)
        {
            Caption = 'Page AL';
        }
        /// <summary>
        /// Indicates whether the page customization is owned by the system or created at the tenant level.
        /// </summary>
        field(6; Owner; Option)
        {
            Caption = 'Owner';
            OptionCaption = 'System,Tenant';
            OptionMembers = System,Tenant;
        }
        /// <summary>
        /// Version number of the compilation emit process, used for tracking customization compilation iterations.
        /// </summary>
        field(7; "Emit Version"; Integer)
        {
            Caption = 'Emit Version';
        }
    }

    keys
    {
        key(Key1; "Profile ID", "Page ID", "App ID", Owner)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

