// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Integration;

/// <summary>
/// Stores document service scenario configurations for different companies and integration services.
/// </summary>
/// <remarks>
/// This table manages document sharing scenarios and service integration settings for external document services like OneDrive.
/// Each record defines how a specific company uses document services for application and platform-level integration.
/// Essential for configuring and managing document sharing capabilities across different integration scenarios.
/// </remarks>
table 2000000115 "Document Service Scenario"
{
    Caption = 'Document Sharing Scenario';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// The type of service integration used for document sharing.
        /// </summary>
        field(1; "Service Integration"; Option)
        {
            OptionCaption = 'OneDrive';
            OptionMembers = "OneDrive";
            Caption = 'Service Integration';
            DataClassification = SystemMetadata;
        }
        /// <summary>
        /// The unique identifier of the company that this scenario configuration applies to.
        /// </summary>
        field(2; "Company"; Guid)
        {
            Caption = 'Company';
            DataClassification = SystemMetadata;
        }
        /// <summary>
        /// The code identifying the specific document service configuration.
        /// </summary>
        field(3; "Document Service"; Code[30])
        {
            Caption = 'Document Service';
            DataClassification = SystemMetadata;
        }
        /// <summary>
        /// Indicates whether this scenario is used for application-level document integration.
        /// </summary>
        field(4; "Use for Application"; Boolean)
        {
            Caption = 'Use for Application';
            DataClassification = SystemMetadata;
        }
        /// <summary>
        /// Indicates whether this scenario is used for platform-level document integration.
        /// </summary>
        field(5; "Use for Platform"; Boolean)
        {
            Caption = 'Use for Platform';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1; "Service Integration", "Company")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

