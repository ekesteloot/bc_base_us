// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Integration;

using System.Security.AccessControl;

/// <summary>
/// Manages webhook subscriptions for API entities, enabling external systems to receive notifications about data changes.
/// </summary>
/// <remarks>
/// This table stores webhook subscription configurations for Business Central's API framework.
/// It enables external applications to subscribe to data change notifications for specific entities.
/// Supports both regular and Dataverse subscription types with configurable expiration dates,
/// notification URLs, and client state management. Used by the API framework to deliver
/// real-time notifications to external systems when subscribed data changes.
/// </remarks>
table 2000000095 "API Webhook Subscription"
{
    Caption = 'API Webhook Subscription';
    DataPerCompany = false;
    Scope = OnPrem;
    ReplicateData = false;

    fields
    {
        /// <summary>
        /// Unique identifier for the webhook subscription.
        /// </summary>
        field(1; "Subscription Id"; Text[150])
        {
            Caption = 'Subscription Id';
        }
        /// <summary>
        /// Publisher namespace of the API entity being subscribed to.
        /// </summary>
        field(2; "Entity Publisher"; Text[40])
        {
            Caption = 'Entity Publisher';
        }
        /// <summary>
        /// Group classification of the API entity being subscribed to.
        /// </summary>
        field(3; "Entity Group"; Text[40])
        {
            Caption = 'Entity Group';
        }
        /// <summary>
        /// Version of the API entity being subscribed to.
        /// </summary>
        field(4; "Entity Version"; Text[10])
        {
            Caption = 'Entity Version';
        }
        /// <summary>
        /// Name of the entity set for which notifications are subscribed.
        /// </summary>
        field(5; "Entity Set Name"; Text[250])
        {
            Caption = 'Entity Set Name';
        }
        /// <summary>
        /// Company name context for the subscription, if company-specific.
        /// </summary>
        field(6; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
        }
        /// <summary>
        /// BLOB field containing the full notification URL where webhook notifications will be sent.
        /// </summary>
        field(7; "Notification Url Blob"; BLOB)
        {
            Caption = 'Notification Url Blob';
        }
        /// <summary>
        /// Security ID of the user who created or owns this webhook subscription.
        /// </summary>
        field(8; "User Id"; Guid)
        {
            DataClassification = EndUserPseudonymousIdentifiers;
            Caption = 'User Id';
            TableRelation = User."User Security ID";
        }
        /// <summary>
        /// Timestamp when the subscription was last modified.
        /// </summary>
        field(9; "Last Modified Date Time"; DateTime)
        {
            Caption = 'Last Modified Date Time';
        }
        /// <summary>
        /// Custom state data provided by the client application for tracking purposes.
        /// </summary>
        field(10; "Client State"; Text[2048])
        {
            DataClassification = CustomerContent;
            Caption = 'Client State';
        }
        /// <summary>
        /// Date and time when the subscription expires and should be automatically removed.
        /// </summary>
        field(11; "Expiration Date Time"; DateTime)
        {
            Caption = 'Expiration Date Time';
        }
        /// <summary>
        /// BLOB field containing the resource URL for the subscribed entity.
        /// </summary>
        field(12; "Resource Url Blob"; BLOB)
        {
            Caption = 'Resource Url Blob';
        }
        /// <summary>
        /// Prefix portion of the notification URL used for indexing and lookup optimization.
        /// </summary>
        field(13; "Notification Url Prefix"; Text[250])
        {
            Caption = 'Notification Url Prefix';
        }
        /// <summary>
        /// ID of the source table that the subscription monitors for changes.
        /// </summary>
        field(14; "Source Table Id"; Integer)
        {
            Caption = 'Source Table Id';
        }
        /// <summary>
        /// Type of subscription defining the notification delivery mechanism.
        /// </summary>
        field(15; "Subscription Type"; Option)
        {
            Caption = 'Subscription Type';
            OptionCaption = 'Regular,Dataverse';
            OptionMembers = Regular,Dataverse;
        }
    }

    keys
    {
        key(Key1; "Subscription Id")
        {
            Clustered = true;
        }
        key(Key2; "Notification Url Prefix")
        {
        }
        key(Key3; "Source Table Id", "Expiration Date Time", "Company Name")
        {
        }
        key(Key4; "Expiration Date Time", "Company Name")
        {
        }
    }

    fieldgroups
    {
    }
}

