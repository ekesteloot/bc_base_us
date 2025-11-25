// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents.Internal;

using System.Agents;
using System.Security.AccessControl;

/// <summary>
/// Stores configuration and metadata for AI agents in the system, including their instructions, properties, and metadata provider settings.
/// </summary>
/// <remarks>
/// This table manages agent definitions and configurations within Business Central's AI agent framework.
/// Each record represents an agent instance with its associated user, instructions, and metadata.
/// The table supports different metadata providers and stores agent-specific properties and instructions as BLOBs.
/// Used by the agent framework for managing AI assistants and their configurations.
/// </remarks>
table 2000000258 "Agent Data"
{
    Caption = 'Agent Data';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;
    Access = Internal;

    fields
    {
        /// <summary>
        /// Security ID of the user associated with this agent.
        /// </summary>
        field(1; "User Security ID"; Guid)
        {
            Caption = 'User Security ID';
            TableRelation = "User"."User Security ID"; // TODO(agent) where ("License Type" = filter('Agent'));
        }
        /// <summary>
        /// Specifies the provider that supplies metadata for this agent.
        /// </summary>
        field(2; "Agent Metadata Provider"; Enum "Agent Metadata Provider")
        {
            Caption = 'Agent Metadata Provider';
            Tooltip = 'Specifies the provider for the agent metadata.';
        }
        /// <summary>
        /// Contains the instructions and prompts that define the agent's behavior and capabilities.
        /// </summary>
        field(3; Instructions; Blob)
        {
            Caption = 'Instructions';
        }
        /// <summary>
        /// Display name of the user associated with this agent, calculated from the User table.
        /// </summary>
        field(4; "User Name"; Code[50])
        {
            CalcFormula = lookup(User."User Name" where("User Security ID" = field("User Security ID")));
            Caption = 'User Name';
            FieldClass = FlowField;
        }
        /// <summary>
        /// Full display name of the user associated with this agent, calculated from the User table.
        /// </summary>
        field(5; "Display Name"; Text[80])
        {
            CalcFormula = lookup(User."Full Name" where("User Security ID" = field("User Security ID")));
            Caption = 'Display Name';
            FieldClass = FlowField;
        }
        /// <summary>
        /// Current state of the agent user (Enabled or Disabled), calculated from the User table.
        /// </summary>
        field(6; "State"; Option)
        {
            CalcFormula = lookup(User."State" where("User Security ID" = field("User Security ID")));
            Caption = 'State';
            FieldClass = FlowField;
            OptionCaption = 'Enabled,Disabled';
            OptionMembers = Enabled,Disabled;
        }
        /// <summary>
        /// Unique identifier of the extension that declared and manages this agent.
        /// </summary>
        field(7; "App ID"; Guid)
        {
            Caption = 'App ID';
            Tooltip = 'Specifies the App ID of the extension that declared the agent.';
        }
        /// <summary>
        /// Hash value of the agent instructions used for change detection and caching.
        /// </summary>
        field(8; "Instructions Hash"; Text[64])
        {
            Caption = 'Instructions Hash';
        }
        /// <summary>
        /// Custom properties and configuration data specific to this agent instance.
        /// </summary>
        field(9; "Properties"; Blob)
        {
            Caption = 'Properties';
            ToolTip = 'Specifies custom properties that can be set on the agent.';
        }
    }

    keys
    {
        key(PK; "User Security ID")
        {
            Clustered = true;
        }
    }
}
