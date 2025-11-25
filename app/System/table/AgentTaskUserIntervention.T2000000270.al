// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents.Internal;

table 2000000270 "Agent Task User Intervention"
{
    Caption = 'Agent Task User Intervention';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;
    Access = Internal;

    fields
    {
        field(1; "Task ID"; BigInteger)
        {
            Caption = 'Task ID';
            TableRelation = "Agent Task Data".ID;
        }
        field(2; "Intervention Request Step No."; Integer)
        {
            Caption = 'User Intervention Request Step Number';
            TableRelation = "Agent Task Step Data"."Step Number";
        }
        field(3; "Intervention Step No."; Integer)
        {
            Caption = 'User Intervention Step Number';
            TableRelation = "Agent Task Step Data"."Step Number";
            ValidateTableRelation = false;
        }
        field(4; "Intervention Request Type"; Text[80])
        {
            Caption = 'User Intervention Request Type';
        }
        field(5; "Agent Task Message ID"; BigInteger)
        {
            Caption = 'Agent Task Message ID';
            TableRelation = "Agent Task Message Data".ID;
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(PK; "Task ID", "Intervention Request Step No.")
        {
            Clustered = true;
        }
    }
}