// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment;

/// <summary>
/// Provides business events for extending user-related functionality including user initialization workflows and session management.
/// </summary>
/// <remarks>
/// This codeunit serves as an extensibility layer for user lifecycle management, enabling partners and developers to implement custom user initialization logic, integrate with external user management systems, and extend session management capabilities. All events are business events that can be subscribed to by external extensions.
/// </remarks>
codeunit 2000000014 "User Triggers"
{
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    /// <summary>
    /// Business event that is triggered after user initialization is completed.
    /// </summary>
    /// <remarks>
    /// Use this event to implement custom user initialization workflows, set up user-specific configurations, integrate with external user management systems, or trigger welcome processes for new users. This event provides an extensibility point for customizing the user onboarding experience.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnAfterUserInitialization()
    begin
    end;
}

