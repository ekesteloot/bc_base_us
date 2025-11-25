// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment.Configuration;

/// <summary>
/// Stores compiled symbol information for profile configurations at the tenant level.
/// This table maintains reference symbols used for profile customization and compilation processes.
/// </summary>
/// <remarks>
/// This table holds binary symbol data for profile configurations, enabling compilation and validation.
/// The reference symbols are stored as BLOB data for performance and space optimization.
/// Data is not company-specific to maintain consistent profile compilation across the tenant.
/// Extensibility points include symbol processing events and custom compilation logic.
/// Related functionality: Profile management, AL compilation, and tenant configuration.
/// </remarks>
table 2000000086 "Profile Configuration Symbols"
{
    Caption = 'Tenant Profile Configuration Symbols';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Unique identifier of the application that owns the profile configuration, used for app-specific symbol management.
        /// </summary>
        field(1; "App ID"; Guid)
        {
            Caption = 'App ID';
        }
        /// <summary>
        /// Identifier of the profile within the application, uniquely identifying the configuration for symbol storage.
        /// </summary>
        field(2; "Profile ID"; Code[30])
        {
            Caption = 'Profile ID';
        }
        /// <summary>
        /// Binary data containing compiled reference symbols for the profile configuration, used for compilation and validation processes.
        /// </summary>
        field(3; "Reference Symbols"; BLOB)
        {
            Caption = 'Reference Symbols';
        }
    }

    keys
    {
        key(Key1; "App ID", "Profile ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

