// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.MCP;

/// <summary>
/// Root configuration record for controlling allowed operations against Business Central objects.
/// </summary>
/// <remarks>
/// This table contains the different MCP server configurations, each identified by a unique 'Configuration ID'.
/// </remarks>
table 2000000292 "MCP Configuration"
{
    Caption = 'MCP Configuration';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;
    DataClassification = CustomerContent;

    fields
    {
        /// <summary>
        /// Configuration name.
        /// </summary>
        field(1; Name; Text[100])
        {
            Caption = 'Name';
        }

        /// <summary>
        /// Configuration description.
        /// </summary>
        field(2; Description; Text[250])
        {
            Caption = 'Description';
        }

        /// <summary>
        /// Use Tool Search Mode.
        /// </summary>
        field(3; EnableDynamicToolMode; Boolean)
        {
            Caption = 'Enable Dynamic Tool Mode';
        }

        /// <summary>
        /// Is configuration active.
        /// </summary>
        field(4; Active; Boolean)
        {
            Caption = 'Active';
        }

        /// <summary>
        /// Allow Create/Modify/Delete operations in Production environments
        /// </summary>
        field(5; AllowProdChanges; Boolean)
        {
            Caption = 'Allow Production Changes';
        }

        /// <summary>
        /// Allow discovery of accessible read-only objects by the MCP client.
        /// </summary>
        field(6; DiscoverReadOnlyObjects; Boolean)
        {
            Caption = 'Enable the dynamic tools to discover additional objects (Read-Only)';
            Description = 'Only supported by DynamicToolMode, it allows the MCP client to search for objects not defined in the configuration.';
        }
    }

    keys
    {
        key(PK; Name)
        {
            Clustered = true;
        }
    }
}