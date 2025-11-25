// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

using System.Security.AccessControl;

table 2000000261 "Agent Access Control"
{
    Caption = 'Agent Access Control';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        field(1; "Agent User Security ID"; Guid)
        {
            Caption = 'Agent User Security ID';
            TableRelation = Agent."User Security ID";
            Tooltip = 'Specifies the unique identifier for the agent user.';
        }
        field(2; "User Security ID"; Guid)
        {
            Caption = 'User Security ID';
            TableRelation = "User"."User Security ID";
            Tooltip = 'Specifies the User Security ID of the user associated with this agent.';
        }
        field(3; "Can Configure Agent"; Boolean)
        {
            Caption = 'Can Configure Agent';
            Tooltip = 'Specifies whether the user can configure this agent.';
        }
    }

    keys
    {
        key(PK; "Agent User Security ID", "User Security ID")
        {
            Clustered = true;
        }
    }
}
