// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment.Consumption;

using System.Security.AccessControl;

table 2000000284 "User Consumption Log Entry"
{
    Caption = 'User Consumption Log Entry';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;
    InherentPermissions = RX;

    fields
    {
        field(1; Id; BigInteger)
        {
            AutoIncrement = true;
            Caption = 'Id';
        }
        field(2; "Consumption Timestamp"; DateTime)
        {
            Caption = 'Consumption Timestamp';
        }
        field(3; "User Id"; Guid)
        {
            DataClassification = EndUserPseudonymousIdentifiers;
            Caption = 'User Id';
            TableRelation = User."User Security ID";
        }
        field(4; "Feature Name"; Text[1024])
        {
            Caption = 'Feature Name';
        }
        field(5; Unit; Text[128])
        {
            Caption = 'Unit';
        }
        field(6; Consumption; Integer)
        {
            Caption = 'Consumption';
        }
        field(7; "Server Session Id"; Guid)
        {
            Caption = 'Server Session Id';
        }
        field(8; "Company Name"; Text[30])
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'Company Name';
        }
    }

    keys
    {
        key("Primary Key"; Id)
        {
            Clustered = true;
        }
        key("Consumption Timestamp Key"; "Consumption Timestamp")
        {
        }
        key("User Id Key"; "User Id")
        {
        }
        key("Feature Name Key"; "Feature Name")
        {
        }
        key("Unit Key"; "Unit")
        {
        }
        key("Server Session Id Key"; "Server Session Id")
        {
        }
        key("Company Name Key"; "Company Name")
        {
        }
    }

    fieldgroups
    {
    }
}

