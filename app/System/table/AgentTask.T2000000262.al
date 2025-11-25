// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

using System.Agents.Internal;
using System.Environment;
using System.Security.AccessControl;

table 2000000262 "Agent Task"
{
    Caption = 'Agent Task';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem; // TODO(agent) - This should change to Cloud when ready to expose agents.

    fields
    {
        field(1; "ID"; BigInteger)
        {
            Caption = 'ID';
            Editable = false;
            Tooltip = 'Specifies the identifier for the agent task.';
        }
        field(2; "Agent User Security ID"; Guid)
        {
            Caption = 'Agent User Security ID';
            Editable = false;
            TableRelation = Agent."User Security ID";
            Tooltip = 'Specifies the unique identifier for the agent user.';
        }
        field(3; "Created By"; Guid)
        {
            Caption = 'Created By';
            Editable = false;
            TableRelation = User."User Security ID";
            Tooltip = 'Specifies the unique identifier for the user that created the agent task.';
        }
        field(4; "Status"; Enum "Agent Task Status")
        {
            Caption = 'Status';
            Tooltip = 'Specifies the status of the agent task.';
        }
        field(5; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            Editable = false;
            TableRelation = Company."Name";
            Tooltip = 'Specifies the company name for the agent task.';
        }
        field(6; "Last Step Number"; Integer)
        {
            Caption = 'Last Step Number';
            Editable = false;
            Tooltip = 'Specifies the last step executed for the agent task.';
        }
        field(7; "Last Step Timestamp"; DateTime)
        {
            Caption = 'Last Step Timestamp';
            Editable = false;
            Tooltip = 'Specifies the timestamp of the last step executed for the agent task.';
        }
        field(8; "Agent User Name"; Code[50])
        {
            Caption = 'Agent User Name';
            Tooltip = 'Specifies the name of the user that is associated with the agent.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Agent"."User Name" where("User Security ID" = field("Agent User Security ID")));
        }
        field(9; "Agent Display Name"; Text[80])
        {
            Caption = 'Agent Display Name';
            Tooltip = 'Specifies the display name of the user that is associated with the agent.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Agent"."Display Name" where("User Security ID" = field("Agent User Security ID")));
        }
        field(10; "Created By User Name"; Code[50])
        {
            Caption = 'Created By User Name';
            Tooltip = 'Specifies the name of the user that created the agent task.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("User"."User Name" where("User Security ID" = field("Created By")));
        }
        field(11; "Created By Full Name"; Text[80])
        {
            Caption = 'Created By Full Name';
            Tooltip = 'Specifies the full name of the user that created the agent task.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("User"."Full Name" where("User Security ID" = field("Created By")));
        }
        field(12; "External ID"; Text[2048])
        {
            Caption = 'External ID';
            Tooltip = 'Specifies the external identifier related to the agent task, such as an Outlook or Teams conversation identifier.';
        }
        field(13; "Title"; Text[150])
        {
            Caption = 'Title';
            ToolTip = 'Specifies the title of the agent task.';
        }
#pragma warning disable AL0468 // Virtual tables are not prone to SQL table name length issues
        field(14; "Created With Current Instructions"; Boolean)
#pragma warning restore AL0468
        {
            Editable = false;
            Caption = 'Created With Current Instructions';
            ToolTip = 'Specifies whether the task was created with the same instructions than the current instructions for the agent.';
        }
        field(15; "Needs Attention"; Boolean)
        {
            Caption = 'Needs Attention';
            ToolTip = 'Specifies whether the task needs attention.';
        }
    }

    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }
}