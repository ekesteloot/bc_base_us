// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Migration;

table 2000000256 "Table Mappings"
{
    Caption = 'Table Mappings';
    DataPerCompany = false;
    Scope = Cloud;
    ReplicateData = false;

    fields
    {
        field(1; "ID"; Integer)
        {
            Caption = 'ID';
            AutoIncrement = true;
        }
        field(2; "From Table Name"; Text[150])
        {
            Caption = 'From Table Name';
        }
        field(3; "From Table SQL Name"; Text[150])
        {
            Caption = 'From Table SQL Name';
        }
        field(4; "From APP ID"; Guid)
        {
            Caption = 'From APP ID';
        }
        field(5; "From App Name"; Text[150])
        {
            Caption = 'From App Name';
        }
        field(6; "From Is Extension Table"; Boolean)
        {
            Caption = 'From Is Extension Table';
        }
        field(7; "From Base Table Name"; Text[150])
        {
            Caption = 'From Base Table Name';
        }
        field(8; "From Base Table SQL Name"; Text[150])
        {
            Caption = 'From Base Table SQL Name';
        }
        field(9; "To Table Name"; Text[150])
        {
            Caption = 'To Table Name';
        }
        field(10; "To Table SQL Name"; Text[150])
        {
            Caption = 'To Table SQL Name';
        }
        field(11; "To APP ID"; Guid)
        {
            Caption = 'To APP ID"';
        }
        field(12; "To App Name"; Text[150])
        {
            Caption = 'To App Name';
        }
        field(13; "To Is Extension Table"; Boolean)
        {
            Caption = 'To Is Extension Table';
        }
        field(14; "To Base Table Name"; Text[150])
        {
            Caption = 'To Base Table Name';
        }
        field(15; "To Base Table SQL Name"; Text[150])
        {
            Caption = 'To Base Table SQL Name';
        }
        field(16; "Inserter App ID"; Guid)
        {
            Caption = 'Inserter App ID';
        }
        field(17; "Applies From BC Major Release"; Integer)
        {
            Caption = 'Applies From BC Major Release';
        }
        field(18; "Applies From BC Minor Release"; Integer)
        {
            Caption = 'Applies From BC Major Release';
        }
        field(19; "Per Company"; boolean)
        {
            Caption = 'Per Company';
        }
        field(20; "From Table ID"; Integer)
        {
            Caption = 'From Table ID';
        }
        field(21; "To Table ID"; Integer)
        {
            Caption = 'To Table ID';
        }
    }

    keys
    {
        key(Key1; "ID")
        {
            Clustered = true;
        }
        key(Key2; "To Table SQL Name", "To App Name", "To APP ID", "To Base Table SQL Name", "Applies From BC Major Release", "Applies From BC Minor Release")
        {
            Unique = true;
        }
    }

    fieldgroups
    {
    }
}

