// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment;

/// <summary>
/// Defines authentication delegation types for scheduled task execution context.
/// Controls how authentication credentials are handled when tasks are scheduled from different session types.
/// </summary>
/// <remarks>
/// Used for managing security context and authentication delegation in scheduled task scenarios.
/// Essential for maintaining proper security boundaries when tasks are created from agent or user sessions.
/// Supports differentiation between standard and agent-initiated scheduled tasks.
/// </remarks>
enum 2000000010 "Scheduled Task Auth Delegation Type"
{
    Extensible = false;
    Caption = 'Scheduled Task Auth Delegation Type';

    /// <summary>
    /// No delegation.
    /// </summary>
    value(0; "None")
    {
        Caption = 'None';
    }

    /// <summary>
    /// Task scheduled from an agent session.
    /// </summary>
    value(1; "Agent")
    {
        Caption = 'Agent';
    }
}