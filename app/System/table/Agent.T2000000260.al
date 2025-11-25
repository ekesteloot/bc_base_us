// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

using System.Reflection;

/// <summary>
/// Virtual table that provides information about AI agents configured in the system.
/// This table enables management and monitoring of automated agents that can perform tasks and interact with users.
/// </summary>
/// <remarks>
/// The Agent table is part of the AI and automation framework in Business Central, providing
/// infrastructure for managing autonomous agents that can perform various business tasks.
/// Each agent has an associated user account, configuration settings, and access controls.
/// Agents can be enabled or disabled, configured through specific pages, and monitored for
/// task completion and attention requirements. This functionality supports the integration
/// of AI-powered automation within business processes while maintaining security and governance.
/// Currently scoped for on-premises deployments during the preview phase.
/// </remarks>
table 2000000260 "Agent"
{
    Caption = 'Agent';
    DataPerCompany = false;
    Scope = OnPrem; // TODO(agent) - This should change to Cloud when ready to expose agents.

    fields
    {
        /// <summary>
        /// The unique security identifier for the user account associated with this agent.
        /// </summary>
        field(1; "User Security ID"; Guid)
        {
            Caption = 'User Security ID';
            Tooltip = 'Specifies the unique identifier for the agent user.';
        }
        /// <summary>
        /// The provider that supplies metadata and configuration information for this agent.
        /// </summary>
        field(2; "Agent Metadata Provider"; Enum "Agent Metadata Provider")
        {
            Caption = 'Agent Metadata Provider';
            Tooltip = 'Specifies the provider for the agent metadata.';
        }
        /// <summary>
        /// The user name of the account associated with this agent.
        /// </summary>
        field(3; "User Name"; Code[50])
        {
            Caption = 'User Name';
            Tooltip = 'Specifies the name of the user that is associated with the agent.';
        }
        /// <summary>
        /// The display name shown for this agent in the user interface.
        /// </summary>
        field(4; "Display Name"; Text[80])
        {
            Caption = 'Display Name';
            Tooltip = 'Specifies the display name of the user that is associated with the agent.';
        }
        /// <summary>
        /// The current operational state of the agent (Enabled or Disabled).
        /// </summary>
        field(5; "State"; Option)
        {
            Caption = 'State';
            OptionCaption = 'Enabled,Disabled';
            OptionMembers = Enabled,Disabled;
            Tooltip = 'Specifies the state of the user that is associated with the agent.';
            InitValue = Disabled;
        }
        /// <summary>
        /// The application identifier of the extension that declared and owns this agent.
        /// </summary>
        field(6; "App ID"; Guid)
        {
            Editable = false;
            Caption = 'App ID';
            Tooltip = 'Specifies the App ID of the extension that declared the agent.';
        }
        /// <summary>
        /// The page used for initial setup and configuration when the agent is first activated.
        /// </summary>
        field(7; "First Time Setup Page ID"; Integer)
        {
            Editable = false;
            Caption = 'First Time Setup Page ID';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Page));
            Tooltip = 'Specifies the ID of the setup page that is used to configure the agent the first time.';
        }
        /// <summary>
        /// The page that displays a summary view of the agent's status and recent activity.
        /// </summary>
        field(8; "Summary Page ID"; Integer)
        {
            Editable = false;
            Caption = 'Summary Page ID';
            Tooltip = 'Specifies the ID of the page that is used to show a summary for the agent.';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Page));
        }
        /// <summary>
        /// The page used for ongoing configuration and management of the agent.
        /// </summary>
        field(9; "Setup Page ID"; Integer)
        {
            Editable = false;
            Caption = 'Setup Page ID';
            Tooltip = 'Specifies the ID of the page that is used to configure the agent.';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Page));
        }
        /// <summary>
        /// Indicates whether the agent has access to data in the current company.
        /// </summary>
        field(10; "Can Access Current Company"; Boolean)
        {
            Editable = false;
            Caption = 'Can Access Current Company';
            Tooltip = 'Specifies whether the agent can access the current company.';
        }
        /// <summary>
        /// The number of tasks assigned to this agent that currently require user attention or intervention.
        /// </summary>
        field(11; "Tasks Needing Attention"; Integer)
        {
            Editable = false;
            Caption = 'Tasks Needing Attention';
            Tooltip = 'The number of tasks for this agent that need attention.';
            FieldClass = FlowField;
            CalcFormula = count("Agent Task" where("Agent User Security ID" = field("User Security ID"),
                                                   "Needs Attention" = const(true)));
        }
        /// <summary>
        /// Indicates whether the current user has permission to interact with and use this agent.
        /// </summary>
        field(12; "Can Current User Use Agent"; Boolean)
        {
            Editable = false;
            Caption = 'Can Current User Use Agent';
            ToolTip = 'Specifies whether the current user can use the agent.';
        }
        /// <summary>
        /// Indicates whether the current user has permission to configure and manage this agent.
        /// </summary>
        field(13; "Can Curr. User Configure Agent"; Boolean)
        {
            Editable = false;
            Caption = 'Can Current User Configure Agent';
            ToolTip = 'Specifies whether the current user can configure the agent.';
        }
        /// <summary>
        /// Binary storage for agent annotations and additional metadata information.
        /// </summary>
        field(14; "Annotations"; Blob)
        {
            Caption = 'Annotations';
            ToolTip = 'Specifies the list of annotation that are set on the agent.';
        }
        /// <summary>
        /// The initials displayed on the agent's icon in the timeline and user interface.
        /// </summary>
        field(15; Initials; Text[4])
        {
            Caption = 'Initials';
            ToolTip = 'Specifies the initials to be displayed on the icon opening the agent''s timeline.';
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