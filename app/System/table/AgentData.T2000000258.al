// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents.Internal;

using System.Agents;
using System.Security.AccessControl;

table 2000000258 "Agent Data"
{
    Caption = 'Agent Data';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;
    Access = Internal;

    fields
    {
        field(1; "User Security ID"; Guid)
        {
            Caption = 'User Security ID';
            TableRelation = "User"."User Security ID"; // TODO(agent) where ("License Type" = filter('Agent'));
        }
        field(2; "Agent Metadata Provider"; Enum "Agent Metadata Provider")
        {
            Caption = 'Agent Metadata Provider';
            Tooltip = 'Specifies the provider for the agent metadata.';
        }
        field(3; Instructions; Blob)
        {
            Caption = 'Instructions';
        }
        field(4; "User Name"; Code[50])
        {
            CalcFormula = lookup(User."User Name" where("User Security ID" = field("User Security ID")));
            Caption = 'User Name';
            FieldClass = FlowField;
        }
        field(5; "Display Name"; Text[80])
        {
            CalcFormula = lookup(User."Full Name" where("User Security ID" = field("User Security ID")));
            Caption = 'Display Name';
            FieldClass = FlowField;
        }
        field(6; "State"; Option)
        {
            CalcFormula = lookup(User."State" where("User Security ID" = field("User Security ID")));
            Caption = 'State';
            FieldClass = FlowField;
            OptionCaption = 'Enabled,Disabled';
            OptionMembers = Enabled,Disabled;
        }
        field(7; "App ID"; Guid)
        {
            Caption = 'App ID';
            Tooltip = 'Specifies the App ID of the extension that declared the agent.';
        }
        field(8; "Instructions Hash"; Text[64])
        {
            Caption = 'Instructions Hash';
        }
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
