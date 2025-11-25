// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Integration;

/// <summary>
/// Stores external event notification records, tracking the delivery status and retry attempts for event notifications.
/// </summary>
/// <remarks>
/// This table manages external event notifications and their delivery status to subscribed endpoints.
/// Each record represents a specific notification attempt for an external event, including retry logic and timing constraints.
/// Essential for reliable external event delivery, providing queuing, retry mechanisms, and delivery tracking.
/// </remarks>
table 2000000242 "External Event Notification"
{
    Caption = 'External Event Notification';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// The identifier of the external event log entry that this notification is based on.
        /// </summary>
        field(1; "Log Entry Id"; Integer)
        {
            Caption = 'Log Entry Id';
            TableRelation = "External Event Log Entry".ID;
        }
        /// <summary>
        /// The unique identifier of the external event subscription that should receive this notification.
        /// </summary>
        field(2; "Subscription Id"; Guid)
        {
            Caption = 'Subscription Id';
            TableRelation = "External Event Subscription".ID;
        }
        /// <summary>
        /// The current status of this notification delivery attempt.
        /// </summary>
        field(3; "Status"; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Pending,Sent,Failed';
            OptionMembers = Pending,Sent,Failed;
        }
        /// <summary>
        /// The date and time of the last retry attempt for this notification.
        /// </summary>
        field(4; "Last Retry Date Time"; DateTime)
        {
            Caption = 'Last Retry Date Time';
        }
        /// <summary>
        /// The number of retry attempts made for this notification.
        /// </summary>
        field(5; "Retry Count"; Integer)
        {
            Caption = 'Retry Count';
        }
        /// <summary>
        /// The earliest date and time when this notification should be processed, used for delaying retry attempts.
        /// </summary>
        field(6; "Not Before"; DateTime)
        {
            Caption = 'Not Before';
        }
    }

    keys
    {
        key(Key1; "Log Entry Id", "Subscription Id")
        {
            Clustered = true;
        }
        key(Key2; "Status", "Not Before", "Subscription Id")
        {
        }
        key(Key3; "Status", "Last Retry Date Time")
        {
        }
        key(Key4; "Log Entry Id")
        {
        }

        key(Key5; "Status")
        {
        }

        key(Key6; "Subscription Id", "SystemCreatedAt", "Status")
        {
        }
    }

    fieldgroups
    {
    }
}

