// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Tooling;

table 2000000289 "Code Coverage Tests Run"
{
    DataPerCompany = false;
    Scope = Cloud;
    fields
    {
        field(1; "Test ID"; Integer)
        {
        }
        field(2; "Object ID"; Integer)
        {
        }
        field(3; "Method ID"; Integer)
        {
        }
        field(4; "Method Name"; Text[2048])
        {
        }
        field(5; "Owning Application"; Guid)
        {
        }
    }
    keys
    {
        key(pk; "Test ID")
        {
        }
    }
}
