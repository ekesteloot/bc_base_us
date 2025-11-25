// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.MCP;

/// <summary>
/// Child records that define allowed operations for specific Business Central objects
/// under a given MCP Configuration.
/// </summary>
/// <remarks>
/// This table contains the different MCP configuration tools, each linked to a parent MCP Configuration record via 'ID'.
/// </remarks>
table 2000000293 "MCP Configuration Tool"
{
    Caption = 'MCP Configuration Tool';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;
    DataClassification = CustomerContent;

    fields
    {
        /// <summary>
        /// MCP Configuration system ID.
        /// </summary>
        field(1; ID; Guid)
        {
            Caption = 'Configuration System ID';
            TableRelation = "MCP Configuration".SystemId;
            NotBlank = true;
        }

        /// <summary>
        /// Type of the Business Central object (Page, Query).
        /// </summary>
        field(2; "Object Type"; Option)
        {
            Caption = 'Object Type';
            OptionMembers = Page;
        }

        /// <summary>
        /// The object ID in Business Central (e.g., Page ID, Query ID).
        /// </summary>
        field(3; "Object ID"; Integer)
        {
            Caption = 'Object ID';
        }

        /// <summary>
        /// Allow read access to the object.
        /// </summary>
        field(10; "Allow Read"; Boolean)
        {
            Caption = 'Allow Read';
        }

        /// <summary>
        /// Allow create access to the object.
        /// </summary>
        field(11; "Allow Create"; Boolean)
        {
            Caption = 'Allow Create';
        }

        /// <summary>
        /// Allow modify access to the object.
        /// </summary>
        field(12; "Allow Modify"; Boolean)
        {
            Caption = 'Allow Modify';
        }

        /// <summary>
        /// Allow delete access to the object.
        /// </summary>
        field(13; "Allow Delete"; Boolean)
        {
            Caption = 'Allow Delete';
        }

        /// <summary>
        /// Optional: Allow bound actions for API pages.
        /// </summary>
        field(14; "Allow Bound Actions"; Boolean)
        {
            Caption = 'Allow Bound Actions';
        }
    }

    keys
    {
        // Uniqueness per configuration + object type + object id
        key(PK; "ID", "Object Type", "Object ID")
        {
            Clustered = true;
        }

        // Helpful for lookups by configuration only
        key(ByConfig; "ID") { }
    }
}