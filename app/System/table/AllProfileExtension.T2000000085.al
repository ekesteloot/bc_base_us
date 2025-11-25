// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment.Configuration;

table 2000000085 "All Profile Extension"
{
    Caption = 'All Profile Extension';
    DataPerCompany = false;
    Scope = Cloud;

    fields
    {
        field(1; "App ID"; Guid)
        {
            Caption = 'App ID';
        }
        field(2; "Profile App ID"; Guid)
        {
            Caption = 'Profile App ID';
        }
        field(3; "Profile ID"; Code[30])
        {
            Caption = 'Profile ID';
        }
        field(4; "App Name"; Text[250])
        {
            Caption = 'App Name';
        }
        field(5; "App Publisher"; Text[250])
        {
            Caption = 'App Publisher';
        }
        field(6; "Profile App Name"; Text[250])
        {
            Caption = 'Profile App Name';
        }
        field(7; "Profile App Publisher"; Text[250])
        {
            Caption = 'Profile App Publisher';
        }
    }

    keys
    {
        key(Key1; "App ID", "Profile App ID", "Profile ID")
        {
            Clustered = true;
        }
    }
}