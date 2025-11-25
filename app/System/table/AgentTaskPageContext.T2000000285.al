// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

/// <summary>
/// Stores context information for agent task page operations including currency, language, and formatting preferences.
/// Provides localization and formatting context for agent communication and page interaction.
/// </summary>
/// <remarks>
/// Temporary table used for passing page context data between agent metadata interfaces and the agent framework.
/// Contains currency, language, and format settings for proper agent communication formatting.
/// Essential for maintaining consistent user experience across different locales and formats.
/// </remarks>
table 2000000285 "Agent Task Page Context"
{
    Caption = 'Agent Task Page Context';
    ReplicateData = false;
    Scope = OnPrem; // TODO(agent) - This should change to Cloud when ready to expose agents.
    TableType = Temporary;

    fields
    {
        /// <summary>
        /// The currency code. Ex: USD.
        /// </summary>
        field(1; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
        }
        /// <summary>
        /// The symbol for the currency. Ex: $.
        /// </summary>
        field(2; "Currency Symbol"; Text[10])
        {
            Caption = 'Currency Symbol';
        }
        /// <summary>
        /// The LCID of the language to be used for outgoing communications.
        /// </summary>
        field(3; "Communication Language LCID"; Integer)
        {
            Caption = 'Communication Language LCID';
        }
        /// <summary>
        /// The LCID of the format to be used for outgoing communications (numbers, dates, times, etc.).
        /// </summary>
        field(4; "Communication Format LCID"; Integer)
        {
            Caption = 'Communication Format LCID';
        }
        /// <summary>
        /// Specifies whether dates in outgoing communications should be in a short date format. Ex: 01/01/2025.
        /// </summary>
        field(5; "Comm. Use Short Date Format"; Boolean)
        {
            Caption = 'Communication Use Short Date Format';
            InitValue = false;
        }
    }
}
