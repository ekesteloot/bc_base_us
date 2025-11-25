// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Device;

/// <summary>
/// Virtual table that provides information about available printers for report output.
/// </summary>
/// <remarks>
/// This table exposes printer configuration and capability information specifically for report printing scenarios.
/// Used by the reporting framework to enumerate available printers and their characteristics when setting up
/// report output destinations. The table includes both system-level printer information and report-specific
/// configuration data. Scoped to OnPrem to access local printer resources.
/// </remarks>
table 2000000229 "Report Printer"
{
    DataPerCompany = False;
    Scope = OnPrem;
    fields
    {
        /// <summary>
        /// The unique identifier for the printer.
        /// </summary>
        field(1; ID; Text[250])
        {
            Caption = 'ID';
        }
        /// <summary>
        /// The display name of the printer.
        /// </summary>
        field(2; Name; Text[250])
        {
            Caption = 'Name';
        }
        /// <summary>
        /// The printer driver name used by the system.
        /// </summary>
        field(3; Driver; Text[50])
        {
            Caption = 'Driver';
        }
        /// <summary>
        /// The device name or port where the printer is connected.
        /// </summary>
        field(4; Device; Text[50])
        {
            Caption = 'Device';
        }
        /// <summary>
        /// Additional configuration data or payload specific to report printing.
        /// </summary>
        field(5; Payload; Text[2048])
        {
            Caption = 'Payload';
        }
        /// <summary>
        /// A detailed description of the printer and its capabilities.
        /// </summary>
        field(6; Description; Text[250])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(pk; ID)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Name, Description)
        {
        }
    }
}