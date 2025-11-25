// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment.Configuration;

/// <summary>
/// Stores configuration packages containing setup data and metadata for Business Central environment initialization and configuration management.
/// </summary>
/// <remarks>
/// This table manages configuration packages for company setup, application configuration, and custom implementations. Supports language-specific packages and processing order control for complex setup scenarios. Used by the configuration management system for rapid deployment and standardized setup processes.
/// </remarks>
table 2000000170 "Configuration Package File"
{
    Caption = 'Configuration Package File';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Unique identifier for the configuration package used for referencing and management operations.
        /// </summary>
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        /// <summary>
        /// Descriptive name for the configuration package used for identification and selection in user interfaces.
        /// </summary>
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        /// <summary>
        /// Language identifier for localized configuration packages enabling language-specific setup and data.
        /// </summary>
        field(3; "Language ID"; Integer)
        {
            Caption = 'Language ID';
        }
        /// <summary>
        /// Classification of the setup package defining the scope and application context for the configuration data.
        /// </summary>
        field(4; "Setup Type"; Option)
        {
            Caption = 'Setup Type';
            OptionCaption = 'Company,Application,Other';
            OptionMembers = Company,Application,Other;
        }
        /// <summary>
        /// Processing sequence number controlling the order of package application during setup operations.
        /// </summary>
        field(5; "Processing Order"; Integer)
        {
            Caption = 'Processing Order';
        }
        /// <summary>
        /// Binary package content containing configuration data, metadata, and setup instructions for deployment.
        /// </summary>
        field(6; Package; BLOB)
        {
            Caption = 'Package';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

