// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Tooling;

table 2000000288 "Code Coverage Test Lookup"
{
    DataPerCompany = false;
    Scope = Cloud;
    fields
    {

        field(1; "Object Type"; Option)
        {
            OptionMembers = ,"Table",,"Report",,"Codeunit","XMLport",,"Page","Query",,,,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension","PermissionSet","PermissionSetExtension","ReportExtension";
            OptionCaption = ',Table,,Report,,Codeunit,XMLport,,Page,Query,,,,,PageExtension,TableExtension,Enum,EnumExtension,Profile,ProfileExtension,PermissionSet,PermissionSetExtension,ReportExtension';
        }
        field(2; "Object ID"; Integer)
        {
        }
        field(3; "Method ID"; Integer)
        {
        }
        field(4; "Test ID"; Integer)
        {
        }
    }
    keys
    {
        key(pk; "Object Type", "Object ID", "Method ID", "Test ID")
        {
        }
    }
}
