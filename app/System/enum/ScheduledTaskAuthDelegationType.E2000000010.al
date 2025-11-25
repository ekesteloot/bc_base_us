// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment;

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