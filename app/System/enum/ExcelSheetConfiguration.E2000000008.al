// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Reflection;

/// <summary>
/// Defines Excel sheet configuration options for report layout generation and data organization.
/// Controls how report data is structured and distributed across Excel worksheets.
/// </summary>
/// <remarks>
/// Used in report layout definitions to control Excel export formatting and sheet organization.
/// Supports fallback to default AL report metadata when undefined values are specified.
/// Essential for flexible Excel report generation and data presentation control.
/// </remarks>
enum 2000000008 "Excel Sheet Configuration"
{
    Extensible = true;
    Caption = 'Excel Sheet Configuration';
    Scope = Cloud;

    /// <summary>
    /// Uses default sheet configuration as defined in AL report metadata.
    /// </summary>
    value(0; Default)
    {
        Caption = 'Default';
    }

    /// <summary>
    /// Generates a single Excel worksheet containing data from all report data items.
    /// </summary>
    value(1; "Single Data sheet")
    {
        Caption = 'Single Data Sheet';
    }

    /// <summary>
    /// Generates separate Excel worksheets for each report data item.
    /// </summary>
    value(2; "Multiple data sheets")
    {
        Caption = 'Multiple Data Sheets';
    }
}