// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment.Configuration;

using System.Reflection;
using System.Security.AccessControl;

/// <summary>
/// Stores user-specific page customizations and metadata, enabling personalized page layouts and configurations.
/// </summary>
/// <remarks>
/// This table maintains user-specific page customizations that override the default page definitions.
/// Each record represents customizations made by a specific user to a specific page, storing both
/// metadata and generated AL code for the customizations. Supports page personalization features
/// that allow users to modify page layouts, field visibility, and other UI elements. Used by the
/// page customization framework to apply user-specific modifications to page rendering.
/// </remarks>
table 2000000188 "User Page Metadata"
{
    Caption = 'User Page Metadata';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;
    InherentPermissions = rX;

    fields
    {
        /// <summary>
        /// Security ID of the user who owns these page customizations.
        /// </summary>
        field(1; "User SID"; Guid)
        {
            Caption = 'User SID';
            TableRelation = User."User Security ID";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        /// <summary>
        /// ID of the page that has been customized by the user.
        /// </summary>
        field(2; "Page ID"; Integer)
        {
            Caption = 'Page ID';
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Page));
        }
        /// <summary>
        /// Metadata describing the page customizations in structured format.
        /// </summary>
        field(3; "Page Metadata"; BLOB)
        {
            Caption = 'Page Metadata';
        }
        /// <summary>
        /// Generated AL code representing the user's page customizations.
        /// </summary>
        field(4; "Page AL"; BLOB)
        {
            Caption = 'Page AL';
        }
        /// <summary>
        /// Version number of the metadata compiler used to generate the customizations.
        /// </summary>
        field(5; "Emit Version"; Integer)
        {
            Caption = 'Emit Version';
        }
    }

    keys
    {
        key(Key1; "User SID", "Page ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

