// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Integration;

/// <summary>
/// Virtual table providing catalog information for external business events defined across extensions.
/// Contains metadata about business events that can be subscribed to by external systems for integration purposes.
/// </summary>
/// <remarks>
/// This table enables discovery and management of business events exposed by extensions for external consumption.
/// Used by integration frameworks, webhook systems, and external service connectors to identify available events.
/// Supports event versioning, categorization, and lifecycle management including obsolescence tracking.
/// </remarks>
table 2000000243 "Ext. Business Event Definition"
{
    Caption = 'External Business Event Catalog';
    DataPerCompany = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Unique identifier of the extension application that defines this business event.
        /// </summary>
        field(1; "App Id"; Guid)
        {
            Caption = 'App Id';
        }
        /// <summary>
        /// Internal name identifier of the business event.
        /// </summary>
        field(2; "Name"; Text[80])
        {
            Caption = 'Name';
        }
        /// <summary>
        /// User-friendly display name for the business event.
        /// </summary>
        field(3; "Display Name"; Text[250])
        {
            Caption = 'Display Name';
        }
        /// <summary>
        /// Detailed description of the business event's purpose and trigger conditions.
        /// </summary>
        field(4; "Description"; Text[1024])
        {
            Caption = 'Description';
        }
        /// <summary>
        /// Category classification for organizing related business events.
        /// </summary>
        field(5; "Category"; Text[250])
        {
            Caption = 'Category';
        }
        /// <summary>
        /// Binary data containing the event payload schema or sample data structure.
        /// </summary>
        field(6; "Payload Blob"; Blob)
        {
            Caption = 'Payload Blob';
        }
        /// <summary>
        /// Name of the extension application that provides this event.
        /// </summary>
        field(7; "App Name"; Text[250])
        {
            Caption = 'App Name';
        }
        /// <summary>
        /// Publisher of the extension application.
        /// </summary>
        field(8; "App Publisher"; Text[250])
        {
            Caption = 'App Publisher';
        }
        /// <summary>
        /// Version number of the extension application.
        /// </summary>
        field(9; "App Version"; Text[43])
        {
            Caption = 'App Version';
        }
        /// <summary>
        /// Version number specific to this business event definition.
        /// </summary>
        field(10; "Event Version"; Text[43])
        {
            Caption = 'Event Version';
        }
        /// <summary>
        /// Indicates whether this business event definition is marked as obsolete.
        /// </summary>
        field(11; "Is Obsolete"; Boolean)
        {
            Caption = 'Is Obsolete';
        }
        /// <summary>
        /// Explanation for why the business event was marked as obsolete.
        /// </summary>
        field(12; "Obsolete Reason"; Text[250])
        {
            Caption = 'Obsolete Reason';
        }
        /// <summary>
        /// Version tag indicating when the business event became obsolete.
        /// </summary>
        field(13; "Obsolete Tag"; Text[43])
        {
            Caption = 'Obsolete Tag';
        }
    }

    keys
    {
        key(Key1; "App Id", "Name", "Event Version")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

