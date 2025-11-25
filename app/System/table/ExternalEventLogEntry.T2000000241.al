// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Integration;

using System.Security.AccessControl;

/// <summary>
/// Stores log entries for external events that have occurred in the system, providing audit trail and event history.
/// </summary>
/// <remarks>
/// This table maintains a log of external events that have been triggered within the system.
/// Each record represents a specific event occurrence, including the triggering app, event details, user context, and payload data.
/// Essential for external event processing, audit trails, and debugging integration issues with external systems.
/// </remarks>
table 2000000241 "External Event Log Entry"
{
    Caption = 'External Event Log Entry';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// The unique identifier for this external event log entry.
        /// </summary>
        field(1; "ID"; Integer)
        {
            AutoIncrement = true;
            Caption = 'ID';
        }
        /// <summary>
        /// The unique identifier of the app that triggered this external event.
        /// </summary>
        field(2; "App Id"; Guid)
        {
            Caption = 'App Id';
        }
        /// <summary>
        /// The version of the app that triggered this external event.
        /// </summary>
        field(3; "App Version"; Text[43])
        {
            Caption = 'App Version';
        }
        /// <summary>
        /// The name or identifier of the external event that was triggered.
        /// </summary>
        field(4; "Event Name"; Text[80])
        {
            Caption = 'Event Name';
        }
        /// <summary>
        /// The name of the company where this external event occurred.
        /// </summary>
        field(5; "Company Name"; Text[30])
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'Company Name';
        }
        /// <summary>
        /// The security ID of the user who triggered this external event.
        /// </summary>
        field(6; "User Id"; Guid)
        {
            DataClassification = EndUserPseudonymousIdentifiers;
            Caption = 'User Id';
            TableRelation = User."User Security ID";
        }
        /// <summary>
        /// The date and time when this external event occurred.
        /// </summary>
        field(7; "Event Date Time"; DateTime)
        {
            Caption = 'Event Date Time';
        }
        /// <summary>
        /// The payload data associated with this external event, stored as binary data.
        /// </summary>
        field(8; "Event Payload Blob"; BLOB)
        {
            Caption = 'Event Payload Blob';
        }
        /// <summary>
        /// Indicates whether this external event log entry has been processed for notification delivery.
        /// </summary>
        field(9; "Processed"; Boolean)
        {
            Caption = 'Processed';
        }
        /// <summary>
        /// The unique identifier of the company where this external event occurred.
        /// </summary>
        field(10; "Company Id"; Guid)
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'Company Id';
        }
        /// <summary>
        /// The version of the event set in the event declaration.
        /// </summary>
        field(11; "Event Version"; Text[43])
        {
            Caption = 'Event Version';
        }
    }

    keys
    {
        key(Key1; "ID")
        {
            Clustered = true;
        }
        key(Key2; "Processed")
        {
        }
    }

    fieldgroups
    {
    }
}

