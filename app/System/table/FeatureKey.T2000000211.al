// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment.Configuration;

/// <summary>
/// Virtual table that provides information about feature flags and preview features available in Business Central.
/// This table enables management of optional features and controls feature enablement across the system.
/// </summary>
/// <remarks>
/// The Feature Key table is central to Business Central's feature management system, allowing administrators
/// to control which preview features and optional functionality is enabled in their environment.
/// It provides information about available features, their descriptions, enablement status, and any
/// requirements or restrictions. This table is essential for feature rollout management, allowing
/// organizations to gradually adopt new functionality while maintaining system stability. The table
/// includes details about mandatory adoption dates, data update requirements, and one-way enablement
/// restrictions that help ensure smooth feature transitions.
/// </remarks>
table 2000000211 "Feature Key"
{
    Caption = 'Feature Key';
    DataPerCompany = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// The unique identifier for the feature key.
        /// </summary>
        field(1; ID; Text[50])
        {
            Caption = 'ID';
        }
        /// <summary>
        /// The enablement status of the feature (None or All Users).
        /// </summary>
        field(2; Enabled; Option)
        {
            Caption = 'Enabled';
            OptionCaption = 'None,All Users';
            OptionMembers = "None","All Users";
        }
        /// <summary>
        /// The detailed description of the feature and its functionality.
        /// </summary>
        field(3; Description; Text[2048])
        {
            Caption = 'Description';
        }
        /// <summary>
        /// A link to additional documentation or information about the feature.
        /// </summary>
        field(4; "Learn More Link"; Text[2048])
        {
            Caption = 'Learn more';
        }
        /// <summary>
        /// The approximate date when this feature will become mandatory if applicable.
        /// </summary>
        field(5; "Mandatory By"; Text[2048])
        {
            Caption = 'Approximate mandatory date';
        }
        /// <summary>
        /// Indicates whether users can try this feature in a trial or demonstration mode.
        /// </summary>
        field(6; "Can Try"; boolean)
        {
            Caption = 'Get started';
        }
        /// <summary>
        /// Indicates whether enabling this feature is irreversible (one-way operation).
        /// </summary>
        field(7; "Is One Way"; Boolean)
        {
            Caption = 'Is One Way';
        }
        /// <summary>
        /// Indicates whether enabling this feature requires a data update or migration process.
        /// </summary>
        field(8; "Data Update Required"; Boolean)
        {
            Caption = 'Data Update Required';
        }
        /// <summary>
        /// The approximate version when this feature will become mandatory if applicable.
        /// </summary>
        field(9; "Mandatory By Version"; Text[2048])
        {
            Caption = 'Approximate mandatory version';
        }
        /// <summary>
        /// The English language description of the feature for reference and translation purposes.
        /// </summary>
        field(10; "Description In English"; Text[2048])
        {
            Caption = 'Description In English';
        }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

