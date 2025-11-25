// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Integration;

/// <summary>
/// Stores webhook subscription configurations for external system notifications and integrations.
/// Manages endpoint registrations and delivery settings for Business Central event notifications.
/// </summary>
/// <remarks>
/// This table enables external applications to subscribe to Business Central events through webhooks,
/// supporting real-time integration scenarios and event-driven architectures. Integrates with
/// notification systems, authentication frameworks, and event publishing mechanisms.
/// </remarks>
table 2000000199 "Webhook Subscription"
{
    Caption = 'Webhook Subscription';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Unique identifier for the webhook subscription registration.
        /// </summary>
        field(1; "Subscription ID"; Text[150])
        {
            Caption = 'Subscription ID';
        }
        /// <summary>
        /// URL endpoint where webhook notifications will be delivered.
        /// </summary>
        field(2; Endpoint; Text[250])
        {
            Caption = 'Endpoint';
        }
        /// <summary>
        /// Client-specific state information for webhook validation and correlation.
        /// </summary>
        field(3; "Client State"; Text[50])
        {
            Caption = 'Client State';
        }
        /// <summary>
        /// User identifier of the person who created this webhook subscription.
        /// </summary>
        field(4; "Created By"; Code[50])
        {
            Caption = 'Created By';
        }
        /// <summary>
        /// User security ID under which webhook notifications will be executed.
        /// </summary>
        field(5; "Run Notification As"; Guid)
        {
            Caption = 'Run Notification As';
        }
        /// <summary>
        /// Company context for company-specific webhook subscriptions.
        /// </summary>
        field(6; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
        }
        /// <summary>
        /// Application identifier for the external system registering the webhook.
        /// </summary>
        field(7; "Application ID"; Text[20])
        {
            Caption = 'Application ID';
        }
    }

    keys
    {
        key(Key1; "Subscription ID", Endpoint)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

