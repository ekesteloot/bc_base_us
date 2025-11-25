// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment;

/// <summary>
/// Virtual table that provides information about active event subscriptions in the system.
/// This table enables monitoring and management of event publisher-subscriber relationships across all applications.
/// </summary>
/// <remarks>
/// The Event Subscription table is crucial for understanding the event-driven architecture within Business Central.
/// It provides visibility into which events are being subscribed to, how often they're called, and their current status.
/// This information is essential for debugging event-related issues, monitoring system performance, and understanding
/// extensibility patterns. The table tracks events from all types including Business Events, Integration Events,
/// and Internal Events, showing both base application and extension-based subscriptions. Each subscription can be
/// individually activated or deactivated, and the table maintains statistics about event usage patterns.
/// </remarks>
table 2000000140 "Event Subscription"
{
    DataPerCompany = false;
    Scope = Cloud;

    //WriteProtexted=True
    fields
    {
        /// <summary>
        /// The codeunit ID that contains the event subscriber function.
        /// </summary>
        field(1; "Subscriber Codeunit ID"; Integer)
        {
        }
        /// <summary>
        /// The name of the function that subscribes to the event.
        /// </summary>
        field(2; "Subscriber Function"; Text[250])
        {
        }
        /// <summary>
        /// The type of event being subscribed to (Trigger, Business, Integration, or Internal).
        /// </summary>
        field(3; "Event Type"; Option)
        {
            OptionMembers = Trigger,Business,Integration,Internal;
        }
        /// <summary>
        /// The type of object that publishes the event (Table, Report, Codeunit, etc.).
        /// </summary>
        field(4; "Publisher Object Type"; Option)
        {
            OptionMembers = ,Table,,Report,,Codeunit,XMLport,,Page,Query,,;
        }
        /// <summary>
        /// The ID of the object that publishes the event.
        /// </summary>
        field(5; "Publisher Object ID"; Integer)
        {
        }
        /// <summary>
        /// The name of the function that publishes the event.
        /// </summary>
        field(6; "Published Function"; Text[250])
        {
        }
        /// <summary>
        /// Indicates whether the event subscription is currently active and will be triggered.
        /// </summary>
        field(7; Active; Boolean)
        {
        }
        /// <summary>
        /// The total number of times this event subscription has been called since system startup.
        /// </summary>
        field(8; "Number of Calls"; BigInteger)
        {
        }
        /// <summary>
        /// Error information if the event subscription has encountered issues during execution.
        /// </summary>
        field(9; "Error Information"; Text[250])
        {
        }
        /// <summary>
        /// The package identifier of the application that contains the subscriber function.
        /// </summary>
        field(10; "Originating Package ID"; Guid)
        {
        }
        /// <summary>
        /// The name of the application that contains the subscriber function.
        /// </summary>
        field(11; "Originating App Name"; Text[250])
        {
        }
        /// <summary>
        /// Instance information for the subscriber when multiple instances are supported.
        /// </summary>
        field(12; "Subscriber Instance"; Text[250])
        {
        }
        /// <summary>
        /// The number of active manual instances for this event subscription.
        /// </summary>
        field(13; "Active Manual Instances"; Integer)
        {
        }
    }

    keys
    {
        key(pk; "Subscriber Codeunit ID", "Subscriber Function")
        {

        }
    }
}