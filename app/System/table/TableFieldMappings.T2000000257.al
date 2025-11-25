// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Migration;

table 2000000257 "Table Field Mappings"
{
    Caption = 'Table Field Mappings';
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
        field(4; "From Table Field Name"; Text[150])
        {
            Caption = 'From Table Field Name';
        }
        field(5; "From Field SQL Name"; Text[150])
        {
            Caption = 'From Field SQL Name';
        }
        field(6; "From APP ID"; Guid)
        {
            Caption = 'From APP ID';
        }
        field(7; "From App Name"; Text[150])
        {
            Caption = 'From App Name';
        }
        field(8; "From Is Extension Table"; Boolean)
        {
            Caption = 'From Is Extension Table';
        }
        field(9; "From Base Table Name"; Text[150])
        {
            Caption = 'From Base Table Name';
        }
        field(10; "From Base Table SQL Name"; Text[150])
        {
            Caption = 'From Base Table SQL Name';
        }
        field(11; "To Table Name"; Text[150])
        {
            Caption = 'To Table Name';
        }
        field(12; "To Table SQL Name"; Text[150])
        {
            Caption = 'To Table SQL Name';
        }
        field(13; "To Table Field Name"; Text[150])
        {
            Caption = 'To Table Field Name';
        }
        field(14; "To Field SQL Name"; Text[150])
        {
            Caption = 'To Field SQL Name';
        }
        field(15; "To APP ID"; Guid)
        {
            Caption = 'To APP ID"';
        }
        field(16; "To App Name"; Text[150])
        {
            Caption = 'To App Name';
        }
        field(17; "To Is Extension Table"; Boolean)
        {
            Caption = 'To Is Extension Table';
        }
        field(18; "To Base Table Name"; Text[150])
        {
            Caption = 'To Base Table Name';
        }
        field(19; "To Base Table SQL Name"; Text[150])
        {
            Caption = 'To Base Table SQL Name';
        }
        field(20; "Inserter App ID"; Guid)
        {
            Caption = 'Inserter App ID';
        }
        field(21; "Applies From BC Major Release"; Integer)
        {
            Caption = 'Applies From BC Major Release';
        }
        field(22; "Applies From BC Minor Release"; Integer)
        {
            Caption = 'Applies From BC Major Release';
        }
        field(23; "Per Company"; boolean)
        {
            Caption = 'Per Company';
        }
    }

    keys
    {
        key(Key1; "ID")
        {
            Clustered = true;
        }
        key(Key2; "To Table SQL Name", "To App Name", "To APP ID", "To Field SQL Name", "To Base Table SQL Name", "Applies From BC Major Release", "Applies From BC Minor Release")
        {
            Unique = true;
        }
    }

    fieldgroups
    {
    }
}

