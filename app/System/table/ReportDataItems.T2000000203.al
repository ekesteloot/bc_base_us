// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Reflection;

/// <summary>
/// Virtual table that provides metadata about data items defined in reports.
/// </summary>
/// <remarks>
/// This table exposes information about the data structure and configuration of report data items,
/// including their relationships, filters, and sorting. Essential for report analysis tools,
/// debugging report data flow, and understanding report dependencies. Used by the reporting framework
/// to introspect report structure and by development tools for report documentation and analysis.
/// </remarks>
table 2000000203 "Report Data Items"
{
    Caption = 'Report Data Items';
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// The ID of the report that contains this data item.
        /// </summary>
        field(1; "Report ID"; Integer)
        {
            Caption = 'Report ID';
        }
        /// <summary>
        /// The unique identifier of the data item within the report.
        /// </summary>
        field(2; "Data Item ID"; Integer)
        {
            Caption = 'Data Item ID';
        }
        /// <summary>
        /// The name of the data item as defined in the report.
        /// </summary>
        field(3; "Name"; Text[250])
        {
            Caption = 'Data Item Name';
        }
        /// <summary>
        /// The fields that can be used for filtering this data item on the request page.
        /// </summary>
        field(4; "Request Filter Fields"; Text[250])
        {
            Caption = 'Request Filter Fields';
        }
        /// <summary>
        /// The ID of the table that this data item is based on.
        /// </summary>
        field(5; "Related Table ID"; Integer)
        {
            Caption = 'Related Table ID';
        }
        /// <summary>
        /// The indentation level of this data item in the report's data structure hierarchy.
        /// </summary>
        field(6; "Indentation Level"; Integer)
        {
            Caption = 'Indentation Level';
        }
        /// <summary>
        /// The fields used for sorting this data item's records.
        /// </summary>
        field(7; "Sorting Fields"; Text[250])
        {
            Caption = 'Sorting Fields';
        }
        /// <summary>
        /// The table view configuration that defines filters and sorting for this data item.
        /// </summary>
        field(8; "Data Item Table View"; Text[1024])
        {
            Caption = 'Data Item Table View';
        }
    }
    keys
    {
        key(PK; "Report ID", "Data Item ID")
        {
        }
    }
}