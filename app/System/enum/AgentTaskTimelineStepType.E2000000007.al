// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

/// <summary>
/// Defines types of steps that can appear in agent task timeline visualization.
/// Provides categorization for timeline display and user interface presentation.
/// </summary>
/// <remarks>
/// Used for organizing and presenting agent task history in timeline format.
/// Essential for user understanding of agent task progression and interaction points.
/// Supports different visualization requirements for various timeline step types.
/// </remarks>
enum 2000000007 "Agent Task Timeline Step Type"
{
    Extensible = false;
    Caption = 'Agent Task Timeline Step Type';
    Scope = OnPrem;

    /// <summary>
    /// The default type.
    /// </summary>
    value(0; Default)
    {
        Caption = 'Default';
    }

    /// <summary>
    /// An input message.
    /// </summary>
    value(1; InputMessage)
    {
        Caption = 'Input Message';
    }

    /// <summary>
    /// An output message.
    /// </summary>
    value(2; OutputMessage)
    {
        Caption = 'Output Message';
    }

    /// <summary>
    /// A user intervention request.
    /// </summary>
    value(3; UserInterventionRequest)
    {
        Caption = 'User Intervention Request';
    }
}