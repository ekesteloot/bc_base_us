// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Integration;

using System.Environment;
using System.Security.AccessControl;

/// <summary>
/// Manages subscriptions to external events, enabling integration with external systems through Dataverse and webhook notifications.
/// </summary>
/// <remarks>
/// This table stores external event subscription configurations that allow Business Central to notify external systems
/// about specific events within the application. Supports both Dataverse and webhook subscription types with configurable
/// notification URLs, client state management, and subscription lifecycle controls. Used by the external event framework
/// to manage event delivery to external subscribers and maintain integration points with external systems.
/// </remarks>
table 2000000240 "External Event Subscription"
{
    Caption = 'External Event Subscription';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Unique identifier for the external event subscription.
        /// </summary>
        field(1; "ID"; Guid)
        {
            Caption = 'ID';
        }
        /// <summary>
        /// Unique identifier of the application that owns this event subscription.
        /// </summary>
        field(2; "App Id"; Guid)
        {
            Caption = 'App Id';
        }
        /// <summary>
        /// Name of the external event being subscribed to.
        /// </summary>
        field(3; "Event Name"; Text[80])
        {
            Caption = 'Event Name';
        }
        /// <summary>
        /// Name of the company context for the subscription, if company-specific.
        /// </summary>
        field(4; "Company Name"; Text[30])
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'Company Name';
            TableRelation = Company.Name;
        }
        /// <summary>
        /// Security ID of the user who created or owns this subscription.
        /// </summary>
        field(5; "User Id"; Guid)
        {
            DataClassification = EndUserPseudonymousIdentifiers;
            Caption = 'User Id';
            TableRelation = User."User Security ID";
        }
        /// <summary>
        /// URL where external event notifications will be sent.
        /// </summary>
        field(6; "Notification Url"; Text[2048])
        {
            Caption = 'Notification Url';
        }
        /// <summary>
        /// Timestamp when the subscription was last modified.
        /// </summary>
        field(7; "Last Modified Date Time"; DateTime)
        {
            Caption = 'Last Modified Date Time';
        }
        /// <summary>
        /// Custom state data provided by the client application for tracking purposes.
        /// </summary>
        field(8; "Client State"; Text[2048])
        {
            DataClassification = CustomerContent;
            Caption = 'Client State';
        }
        /// <summary>
        /// Type of subscription defining the notification delivery mechanism.
        /// </summary>
        field(9; "Subscription Type"; Option)
        {
            Caption = 'Subscription Type';
            OptionCaption = 'Dataverse,Webhook';
            OptionMembers = Dataverse,Webhook;
        }
        /// <summary>
        /// Version of the external event as declared in the event definition.
        /// </summary>
        field(10; "Event Version"; Text[43])
        {
            Caption = 'Event Version';
        }
        /// <summary>
        /// Current state of the subscription controlling whether notifications are active.
        /// </summary>
        field(11; "Subscription State"; Option)
        {
            Caption = 'Subscription State';
            OptionCaption = 'Active,Disabled';
            OptionMembers = Active,Disabled;
        }
    }

    keys
    {
        key(Key1; "ID")
        {
            Clustered = true;
        }
        key(Key2; "App Id", "Event Name")
        {
        }
        key(Key3; "Subscription State")
        {
        }
    }

    fieldgroups
    {
    }
}

