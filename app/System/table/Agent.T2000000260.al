// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

using System.Reflection;

table 2000000260 "Agent"
{
    Caption = 'Agent';
    DataPerCompany = false;
    Scope = OnPrem; // TODO(agent) - This should change to Cloud when ready to expose agents.

    fields
    {
        field(1; "User Security ID"; Guid)
        {
            Caption = 'User Security ID';
            Tooltip = 'Specifies the unique identifier for the agent user.';
        }
        field(2; "Agent Metadata Provider"; Enum "Agent Metadata Provider")
        {
            Caption = 'Agent Metadata Provider';
            Tooltip = 'Specifies the provider for the agent metadata.';
        }
        field(3; Instructions; Blob)
        {
            Caption = 'Instructions';
            Tooltip = 'Specifies the instructions for the agent.';
        }
        field(4; "User Name"; Code[50])
        {
            Caption = 'User Name';
            Tooltip = 'Specifies the name of the user that is associated with the agent.';
        }
        field(5; "Display Name"; Text[80])
        {
            Caption = 'Display Name';
            Tooltip = 'Specifies the display name of the user that is associated with the agent.';
        }
        field(6; "State"; Option)
        {
            Caption = 'State';
            OptionCaption = 'Enabled,Disabled';
            OptionMembers = Enabled,Disabled;
            Tooltip = 'Specifies the state of the user that is associated with the agent.';
            InitValue = Disabled;
        }
        field(7; "App ID"; Guid)
        {
            Editable = false;
            Caption = 'App ID';
            Tooltip = 'Specifies the App ID of the extension that declared the agent.';
        }
        field(8; "First Time Setup Page ID"; Integer)
        {
            Editable = false;
            Caption = 'First Time Setup Page ID';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Page));
            Tooltip = 'Specifies the ID of the setup page that is used to configure the agent the first time.';
        }
        field(9; "Summary Page ID"; Integer)
        {
            Editable = false;
            Caption = 'Summary Page ID';
            Tooltip = 'Specifies the ID of the page that is used to show a summary for the agent.';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Page));
        }
        field(10; "Setup Page ID"; Integer)
        {
            Editable = false;
            Caption = 'Setup Page ID';
            Tooltip = 'Specifies the ID of the page that is used to configure the agent.';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Page));
        }
        field(11; "Can Access Current Company"; Boolean)
        {
            Editable = false;
            Caption = 'Can Access Current Company';
            Tooltip = 'Specifies whether the agent can access the current company.';
        }
        field(12; "Tasks Needing Attention"; Integer)
        {
            Editable = false;
            Caption = 'Tasks Needing Attention';
            Tooltip = 'The number of tasks for this agent that need attention.';
            FieldClass = FlowField;
            CalcFormula = count("Agent Task" where("Agent User Security ID" = field("User Security ID"),
                                                   "Needs Attention" = const(true)));
        }
        field(13; "Can Current User Use Agent"; Boolean)
        {
            Editable = false;
            Caption = 'Can Current User Use Agent';
            ToolTip = 'Specifies whether the current user can use the agent.';
        }
        field(14; "Can Curr. User Configure Agent"; Boolean)
        {
            Editable = false;
            Caption = 'Can Current User Configure Agent';
            ToolTip = 'Specifies whether the current user can configure the agent.';
        }
        field(15; "Annotations"; Blob)
        {
            Caption = 'Annotations';
            ToolTip = 'Specifies the list of annotation that are set on the agent.';
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