// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Reflection;

/// <summary>
/// This enumeration is used to represent a boolean value in the report layout definition that can be either true or false, or undefined.
/// In the latter case, the value will fallback to a default value given in the AL report metadata.
/// </summary>
enum 2000000008 "Excel Sheet Configuration"
{
    Extensible = true;
    Caption = 'Excel Sheet Configuration';
    Scope = Cloud;

    /// <summary>
    /// The undefined (default) type.
    /// </summary>
    value(0; Default)
    {
        Caption = 'Default';
    }

    /// <summary>
    /// The single sheet option (one datasheet for all data items).
    /// </summary>
    value(1; "Single Data sheet")
    {
        Caption = 'Single Data Sheet';
    }

    /// <summary>
    /// The Multiple data sheets.
    /// </summary>
    value(2; "Multiple data sheets")
    {
        Caption = 'Multiple Data Sheets';
    }
}