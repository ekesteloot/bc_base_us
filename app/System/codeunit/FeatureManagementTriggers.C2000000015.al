// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment;

/// <summary>
/// Provides business events for feature management functionality and configuration access.
/// Enables extensions to respond to feature management operations and settings access.
/// </summary>
/// <remarks>
/// Contains events for feature management user interface and configuration operations.
/// Essential for extensions requiring feature management integration or custom feature handling.
/// Supports feature management operations and user access to feature configuration.
/// </remarks>
codeunit 2000000015 "Feature Management Triggers"
{
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    /// <summary>
    /// Business event raised when feature management functionality is accessed.
    /// Enables custom feature management logic or UI redirection.
    /// </summary>
    /// <remarks>
    /// Raised when user requests access to feature management configuration.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OpenFeatureManagement()
    begin
    end;
}

