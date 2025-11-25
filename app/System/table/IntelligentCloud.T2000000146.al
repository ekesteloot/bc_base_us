// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Integration;

/// <summary>
/// Stores the global configuration setting for Intelligent Cloud functionality enabling cloud migration and hybrid scenarios.
/// </summary>
/// <remarks>
/// This table maintains the central configuration for Intelligent Cloud features within Business Central.
/// It contains a single record that controls whether Intelligent Cloud functionality is enabled for the tenant.
/// Used by the cloud migration framework to determine if cloud migration features should be available
/// and active. The table uses a singleton pattern with a fixed primary key to ensure only one configuration
/// record exists per tenant.
/// </remarks>
table 2000000146 "Intelligent Cloud"
{
    Caption = 'Intelligent Cloud';
    DataPerCompany = false;
    Scope = OnPrem;
    ReplicateData = false;
    InherentPermissions = rX;

    fields
    {
        /// <summary>
        /// Fixed primary key for the singleton configuration record.
        /// </summary>
        field(1; "Primary Key"; Text[10])
        {
            Caption = 'Primary Key';
        }
        /// <summary>
        /// Indicates whether Intelligent Cloud functionality is enabled for this tenant.
        /// </summary>
        field(2; Enabled; Boolean)
        {
            Caption = 'Enabled';
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

