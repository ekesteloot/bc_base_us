// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment.Configuration;

table 2000000246 "All Profile Page Metadata"
{
    Caption = 'All Profile Page Metadata';
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
        field(4; "Page ID"; Integer)
        {
            Caption = 'Page ID';
        }
        field(5; "App Name"; Text[250])
        {
            Caption = 'App Name';
        }
        field(6; "App Publisher"; Text[250])
        {
            Caption = 'App Publisher';
        }
        field(7; "Profile App Name"; Text[250])
        {
            Caption = 'Profile App Name';
        }
        field(8; "Profile App Publisher"; Text[250])
        {
            Caption = 'Profile App Publisher';
        }
    }

    keys
    {
        key(Key1; "App ID", "Profile App ID", "Profile ID", "Page ID")
        {
            Clustered = true;
        }
    }
}