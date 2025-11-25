// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Integration;

using System.Security.AccessControl;

/// <summary>
/// Stores aggregated API webhook notification data for batch processing and delivery optimization.
/// </summary>
/// <remarks>
/// This table manages aggregated webhook notifications to optimize delivery performance and reduce redundant calls.
/// It groups multiple related notifications into single aggregated entries, reducing the number of webhook calls to external systems.
/// Essential for webhook notification delivery in high-volume scenarios where multiple events need to be communicated to subscribers.
/// </remarks>
table 2000000098 "API Webhook Notification Aggr"
{
    Caption = 'API Webhook Notification Aggr';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// The unique identifier for this aggregated notification record.
        /// </summary>
        field(1; ID; Guid)
        {
            Caption = 'ID';
        }
        /// <summary>
        /// The identifier of the webhook subscription this aggregated notification belongs to.
        /// </summary>
        field(2; "Subscription ID"; Text[150])
        {
            Caption = 'Subscription ID';
        }
        /// <summary>
        /// The security ID of the user who created this aggregated notification.
        /// </summary>
        field(3; "Created By User SID"; Guid)
        {
            Caption = 'Created By User SID';
            DataClassification = EndUserPseudonymousIdentifiers;
            TableRelation = User."User Security ID";
        }
        /// <summary>
        /// The key value of the entity related to this notification, used for identifying the specific record in the entity table.
        /// </summary>
        field(4; "Entity Key Value"; Text[250])
        {
            Caption = 'Entity Key Value';
        }
        /// <summary>
        /// The date and time when this aggregated notification was last modified.
        /// </summary>
        field(5; "Last Modified Date Time"; DateTime)
        {
            Caption = 'Last Modified Date Time';
        }
        /// <summary>
        /// The type of change that triggered this notification, indicating whether the change was the creation, update, or deletion of a record, or a collection change.
        /// </summary>
        field(6; "Change Type"; Option)
        {
            Caption = 'Change Type';
            OptionCaption = 'Created,Updated,Deleted,Collection';
            OptionMembers = Created,Updated,Deleted,Collection;
        }
        /// <summary>
        /// The number of attempts made to process or deliver this notification, useful for tracking and debugging delivery issues.
        /// </summary>
        field(7; "Attempt No."; Integer)
        {
            Caption = 'Attempt No.';
        }
        /// <summary>
        /// The date and time when this notification is scheduled to be sent, allowing for delayed or scheduled delivery of notifications.
        /// </summary>
        field(8; "Sending Scheduled Date Time"; DateTime)
        {
            Caption = 'Sending Scheduled Date Time';
        }
        /// <summary>
        /// The unique identifier of the entity instance related to this notification, providing a direct link to the affected record in the entity table.
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
    }

    fieldgroups
    {
    }
}

