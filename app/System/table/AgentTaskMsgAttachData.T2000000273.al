// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents.Internal;

using System.Agents;
using System.Environment;
using System.Security.AccessControl;

table 2000000273 "Agent Task Msg Attach Data"
{
    Caption = 'Agent Task Message Attachment Data';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;
    Access = Internal;

    fields
    {
        field(1; "Task ID"; BigInteger)
        {
            TableRelation = "Agent Task Data".ID;
        }
        field(2; "Message ID"; BigInteger)
        {
            TableRelation = "Agent Task Message Data".ID Where("Task ID" = Field("Task ID"));
        }
        field(3; "File ID"; BigInteger)
        {
            TableRelation = "Agent Task File Data"."ID" Where("Task ID" = Field("Task ID"));
        }
        field(4; "Message System ID"; Guid)
        {
            CalcFormula = Lookup("Agent Task Message Data".SystemId Where("Task ID" = Field("Task ID"), "ID" = Field("Message ID")));
            FieldClass = FlowField;
        }
        field(5; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Data"."Company Name" where(ID = field("Task ID")));
        }
        field(6; "Task Agent User Security ID"; Guid)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Agent Task Data"."Agent User Security ID" where(ID = field("Task ID")));
        }
    }

    keys
    {
        key(PK; "Task ID", "Message ID", "File ID")
        {
            Clustered = true;
        }
        key(TaskIdMessageId; "Task ID", "Message ID")
        {
            Unique = false;
        }
    }
}