// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Integration;

/// <summary>
/// Stores activity log entries for external event processing, tracking the status and details of external event notifications.
/// </summary>
/// <remarks>
/// This table manages the activity log for external event notifications, recording delivery attempts, status, and error details.
/// Each record represents an attempt to deliver an external event notification to a subscribed endpoint.
/// Essential for monitoring and troubleshooting external event integration, providing audit trail and delivery status tracking.
/// </remarks>
table 2000000245 "External Event Activity Log"
{
    Caption = 'External Event Activity Log';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;
    InherentEntitlements = RI;

    fields
    {
        /// <summary>
        /// The unique identifier for this activity log entry.
        /// </summary>
        field(1; "Id"; Integer)
        {
            AutoIncrement = true;
            Caption = 'ID';
        }
        /// <summary>
        /// The URL endpoint where the external event notification was sent.
        /// </summary>
        field(2; "Notification Url"; Text[2048])
        {
            Caption = 'Notification Url';
        }
        /// <summary>
        /// The unique identifier of the external event subscription associated with this activity.
        /// </summary>
        field(3; "Subscription Id"; Guid)
        {
            Caption = 'Subscription Id';
        }
        /// <summary>
        /// The status of the external event notification delivery attempt.
        /// </summary>
        field(4; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Success,Failed';
            OptionMembers = Success,Failed;
        }
        /// <summary>
        /// A descriptive message about the activity or any error that occurred during delivery.
        /// </summary>
        field(5; "Activity Message"; Text[250])
        {
            Caption = 'Activity Message';
        }
        /// <summary>
        /// The unique identifier of the company where the external event originated.
        /// </summary>
        field(6; "Company Id"; Guid)
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'Company Id';
        }
        /// <summary>
        /// The name of the company where the external event originated.
        /// </summary>
        field(7; "Company Name"; Text[30])
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'Company Name';
        }
    }

    keys
    {
        key(Key1; "Id")
        {
            Clustered = true;
        }
        key(Key2; "SystemCreatedAt", "Id")
        {
        }
    }

    fieldgroups
    {
    }
}

