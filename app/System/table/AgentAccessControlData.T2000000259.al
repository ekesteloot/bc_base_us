// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents.Internal;

using System.Security.AccessControl;

/// <summary>
/// Manages access control permissions for AI agents, defining which users can configure specific agents.
/// </summary>
/// <remarks>
/// This table establishes the security model for agent management by linking users with specific agents
/// and their configuration permissions. It enables fine-grained access control over who can modify
/// agent settings, instructions, and properties. Used by the agent framework to enforce security
/// policies and ensure only authorized users can configure agent behavior.
/// </remarks>
table 2000000259 "Agent Access Control Data"
{
    Caption = 'Agent Access Control Data';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;
    Access = Internal;

    fields
    {
        /// <summary>
        /// Security ID of the agent user whose access is being controlled.
        /// </summary>
        field(1; "Agent User Security ID"; Guid)
        {
            Caption = 'Agent User Security ID';
            TableRelation = "Agent Data"."User Security ID"; // TODO where("License Type" = filter('Agent'));
        }
        /// <summary>
        /// Security ID of the user who has access to configure the agent.
        /// </summary>
        field(2; "User Security ID"; Guid)
        {
            Caption = 'User Security ID';
            TableRelation = "User"."User Security ID";
        }
        /// <summary>
        /// Indicates whether the user has permission to configure the agent's settings and behavior.
        /// </summary>
        field(3; "Can Configure Agent"; Boolean)
        {
            Caption = 'Can Configure Agent';
        }
    }

    keys
    {
        key(PK; "Agent User Security ID", "User Security ID")
        {
            Clustered = true;
        }

        key(UserSecurityID; "User Security ID")
        {
        }
    }
}