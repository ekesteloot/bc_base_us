// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Integration;

using System.Security.AccessControl;

/// <summary>
/// Stores individual notification records for API webhook events, tracking specific data changes that trigger webhook notifications.
/// </summary>
/// <remarks>
/// This table contains the notification records generated when API entities change and need to be communicated to
/// webhook subscribers. Each record represents a specific entity change with metadata about the change type,
/// entity identification, and timing information. Works with the API webhook subscription framework to queue
/// and deliver notifications to external systems. Used by the API notification system to track individual
/// change events and ensure reliable delivery of webhook notifications.
/// </remarks>
table 2000000096 "API Webhook Notification"
{
    Caption = 'API Webhook Notification';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Unique identifier for the webhook notification record.
        /// </summary>
        field(1; ID; Guid)
        {
            Caption = 'ID';
        }
        /// <summary>
        /// Identifier of the webhook subscription this notification belongs to.
        /// </summary>
        field(2; "Subscription ID"; Text[150])
        {
            Caption = 'Subscription ID';
        }
        /// <summary>
        /// Security ID of the user who triggered the change that generated this notification.
        /// </summary>
        field(3; "Created By User SID"; Guid)
        {
            DataClassification = EndUserPseudonymousIdentifiers;
            Caption = 'Created By User SID';
            TableRelation = User."User Security ID";
        }
        /// <summary>
        /// Key value of the entity that changed, used for entity identification.
        /// </summary>
        field(4; "Entity Key Value"; Text[250])
        {
            Caption = 'Entity Key Value';
        }
        /// <summary>
        /// Timestamp when the entity was last modified, triggering this notification.
        /// </summary>
        field(5; "Last Modified Date Time"; DateTime)
        {
            Caption = 'Last Modified Date Time';
        }
        /// <summary>
        /// Type of change that occurred to the entity (Created, Updated, Deleted, Collection).
        /// </summary>
        field(6; "Change Type"; Option)
        {
            Caption = 'Change Type';
            OptionCaption = 'Created,Updated,Deleted,Collection';
            OptionMembers = Created,Updated,Deleted,Collection;
        }
        /// <summary>
        /// Unique identifier of the entity that changed.
        /// </summary>
        field(9; "Entity ID"; Guid)
        {
            Caption = 'Entity ID';
        }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
        key(Key2; "Subscription ID")
        {
        }
        key(Key3; "Last Modified Date Time")
        {
        }
    }

    fieldgroups
    {
    }
}

