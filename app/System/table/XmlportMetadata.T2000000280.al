// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Reflection;

table 2000000280 "XmlPort Metadata"
{
    DataPerCompany = False;
    Scope = Cloud;
    InherentPermissions = rX;

    fields
    {
        field(1; ID; Integer)
        {
        }
        field(2; Name; Text[30])
        {
        }
        field(3; Caption; Text[80])
        {
        }
        field(4; UseRequestPage; Boolean)
        {
        }
        field(5; TransactionType; Option)
        {
            OptionMembers = UpdateNoLocks,Update,Snapshot,Browse,Report;
        }
        field(6; Direction; Option)
        {
            OptionMembers = Import,Export,Both;
        }
        field(7; Encoding; Option)
        {
            OptionMembers = UTF8,UTF16,ISO88592;
        }
        field(8; TextEncoding; Option)
        {
            OptionMembers = MSDos,UTF8,UTF16,Windows;
        }
        field(9; Format; Option)
        {
            OptionMembers = Xml,VariableText,FixedText;
        }
        field(10; "App ID"; Guid)
        {
        }
        field(11; InherentPermissions; Text[5])
        {
        }
        field(12; InherentEntitlements; Text[5])
        {
        }
    }
}