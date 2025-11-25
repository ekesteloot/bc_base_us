// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents.Internal;

using System.Security.AccessControl;

table 2000000259 "Agent Access Control Data"
{
    Caption = 'Agent Access Control Data';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;
    Access = Internal;

    fields
    {
        field(1; "Agent User Security ID"; Guid)
        {
            Caption = 'Agent User Security ID';
            TableRelation = "Agent Data"."User Security ID"; // TODO where("License Type" = filter('Agent'));
        }
        field(2; "User Security ID"; Guid)
        {
            Caption = 'User Security ID';
            TableRelation = "User"."User Security ID";
        }
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