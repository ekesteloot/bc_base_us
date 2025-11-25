// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment.Consumption;

using System.Security.AccessControl;

/// <summary>
/// Records user consumption events for features and services, enabling usage tracking, billing, and analytics at the tenant level.
/// This table provides detailed logging of resource consumption for monitoring, auditing, and capacity planning purposes.
/// </summary>
/// <remarks>
/// This table logs individual consumption events with timestamps, user identification, and consumption metrics.
/// Supports various consumption units and feature categorization for flexible usage tracking scenarios.
/// Data is not company-specific but tracks company association for proper consumption attribution.
/// Extensibility points include custom consumption logging events and consumption aggregation logic.
/// Related functionality: Usage analytics, billing systems, and resource monitoring.
/// </remarks>
table 2000000284 "User Consumption Log Entry"
{
    Caption = 'User Consumption Log Entry';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;
    InherentPermissions = RX;
    ObsoleteState = Pending;
    ObsoleteReason = 'This table will be removed (has never been used).';

    fields
    {
        /// <summary>
        /// Auto-incrementing unique identifier for each consumption log entry, providing primary key functionality for tracking individual events.
        /// </summary>
        field(1; Id; BigInteger)
        {
            AutoIncrement = true;
            Caption = 'Id';
        }
        /// <summary>
        /// Date and time when the consumption event occurred, used for temporal analysis and billing period calculations.
        /// </summary>
        field(2; "Consumption Timestamp"; DateTime)
        {
            Caption = 'Consumption Timestamp';
        }
        /// <summary>
        /// Security identifier of the user who triggered the consumption event, used for user-specific usage tracking and billing attribution.
        /// </summary>
        field(3; "User Id"; Guid)
        {
            DataClassification = EndUserPseudonymousIdentifiers;
            Caption = 'User Id';
            TableRelation = User."User Security ID";
        }
        /// <summary>
        /// Name of the feature or service that was consumed, providing categorization for usage analysis and billing purposes.
        /// </summary>
        field(4; "Feature Name"; Text[1024])
        {
            Caption = 'Feature Name';
        }
        /// <summary>
        /// Unit of measurement for the consumption amount, such as API calls, storage bytes, or processing time.
        /// </summary>
        field(5; Unit; Text[128])
        {
            Caption = 'Unit';
        }
        /// <summary>
        /// Numeric amount of consumption in the specified unit, used for usage calculations and billing computations.
        /// </summary>
        field(6; Consumption; Integer)
        {
            Caption = 'Consumption';
        }
        /// <summary>
        /// Unique identifier of the server session during which the consumption occurred, used for session-based analysis and debugging.
        /// </summary>
        field(7; "Server Session Id"; Guid)
        {
            Caption = 'Server Session Id';
        }
        /// <summary>
        /// Name of the company context in which the consumption occurred, used for company-specific usage attribution and billing.
        /// </summary>
        field(8; "Company Name"; Text[30])
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'Company Name';
        }
    }

    keys
    {
        key("Primary Key"; Id)
        {
            Clustered = true;
        }
        key("Consumption Timestamp Key"; "Consumption Timestamp")
        {
        }
        key("User Id Key"; "User Id")
        {
        }
        key("Feature Name Key"; "Feature Name")
        {
        }
        key("Unit Key"; "Unit")
        {
        }
        key("Server Session Id Key"; "Server Session Id")
        {
        }
        key("Company Name Key"; "Company Name")
        {
        }
    }

    fieldgroups
    {
    }
}

