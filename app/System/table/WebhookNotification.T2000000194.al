// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Integration;

/// <summary>
/// Stores individual webhook notification messages that are sent to external systems about data changes.
/// </summary>
/// <remarks>
/// This table contains the actual notification payloads that are delivered to webhook subscribers when
/// data changes occur in Business Central. Each notification includes metadata about the change type,
/// resource affected, and the notification content in JSON format. Works with webhook subscription
/// management to provide reliable delivery of change notifications to external systems. Used by the
/// webhook framework to queue, track, and deliver notifications to subscribed endpoints.
/// </remarks>
table 2000000194 "Webhook Notification"
{
    Caption = 'Webhook Notification';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Unique identifier for the webhook notification.
        /// </summary>
        field(1; ID; Guid)
        {
            Caption = 'ID';
        }
        /// <summary>
        /// Sequence number for ordering notifications within a subscription.
        /// </summary>
        field(2; "Sequence Number"; Integer)
        {
            Caption = 'Sequence Number';
        }
        /// <summary>
        /// Identifier of the webhook subscription this notification belongs to.
        /// </summary>
        field(3; "Subscription ID"; Text[150])
        {
            Caption = 'Subscription ID';
        }
        /// <summary>
        /// Identifier of the specific resource that changed and triggered this notification.
        /// </summary>
        field(4; "Resource ID"; Text[250])
        {
            Caption = 'Resource ID';
        }
        /// <summary>
        /// Type of change that occurred (e.g., Created, Updated, Deleted).
        /// </summary>
        field(5; "Change Type"; Text[50])
        {
            Caption = 'Change Type';
        }
        /// <summary>
        /// Name of the resource type that was affected by the change.
        /// </summary>
        field(6; "Resource Type Name"; Text[250])
        {
            Caption = 'Resource Type Name';
        }
        /// <summary>
        /// JSON payload containing the notification data to be sent to the webhook endpoint.
        /// </summary>
        field(7; Notification; BLOB)
        {
            Caption = 'Notification';
            SubType = Json;
        }
    }

    keys
    {
        key(Key1; ID, "Resource Type Name", "Sequence Number", "Subscription ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

