// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.AI;

/// <summary>
/// Defines available Copilot capabilities and AI-powered features within the system.
/// Provides capability management for different AI functionality types and permission control.
/// </summary>
/// <remarks>
/// Used for enabling and controlling access to specific AI capabilities based on licensing and configuration.
/// Supports extensibility for custom AI capabilities while maintaining centralized capability management.
/// Essential for AI feature governance and user permission management.
/// </remarks>
enum 2000000003 "Copilot Capability"
{
    Extensible = true;
    Caption = 'Copilot Capability';

    /// <summary>
    /// Interactive chat functionality for conversational AI assistance.
    /// </summary>
    value(1; Chat)
    {
        Caption = 'Chat';
    }
    /// <summary>
    /// AI-powered analysis capabilities for data lists and collections.
    /// </summary>
    value(2; "Analyze List")
    {
        Caption = 'Analyze list';
    }
    /// <summary>
    /// Content summarization functionality for documents and data.
    /// </summary>
    value(3; Summarize)
    {
        Caption = 'Summarize';
    }
    /// <summary>
    /// Automated field completion and data entry assistance.
    /// </summary>
    value(4; Autofill)
    {
        Caption = 'Autofill';
    }
}