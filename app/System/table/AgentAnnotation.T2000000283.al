// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

/// <summary>
/// Stores annotation data for agent validation and user feedback in agent operations.
/// Provides structured feedback mechanism for agent tasks and operations with severity-based classification.
/// </summary>
/// <remarks>
/// Temporary table used for passing annotation data between agent validation interfaces and the agent framework.
/// Supports Info, Warning, and Error severity levels for different validation scenarios.
/// Essential for agent operation integrity and user oversight through the validation system.
/// </remarks>
table 2000000283 "Agent Annotation"
{
    Caption = 'Agent Annotation';
    ReplicateData = false;
    Scope = OnPrem; // TODO(agent) - This should change to Cloud when ready to expose agents.
    TableType = Temporary;

    fields
    {
        /// <summary>
        /// The unique identifier for the annotation. This ID is logged into telemetry.
        /// </summary>
        field(1; "Code"; Text[20])
        {
            Caption = 'Code';
            Tooltip = 'The code defining the type of annotation.';
        }
        /// <summary>
        /// The message of the annotation appearing in the timeline.
        /// This should be localized in the agent's language (see "User Personalization"."Language ID").
        /// </summary>
        field(2; "Message"; Text[2048])
        {
            Caption = 'Message';
            Tooltip = 'The message of the annotation.';
        }
        /// <summary>
        /// The details of the annotation appearing in the timeline.
        /// This should be localized in the agent's language (see "User Personalization"."Language ID").
        /// </summary>
        field(3; "Details"; Text[2048])
        {
            Caption = 'Details';
            Tooltip = 'The details of the annotation.';
        }
        /// <summary>
        /// The severity of the annotation.
        /// </summary>
        field(4; "Severity"; Option)
        {
            Caption = 'Severity';
            OptionCaption = 'Info,Warning,Error';
            OptionMembers = Info,Warning,Error;
            Tooltip = 'The severity of the annotation.';
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
