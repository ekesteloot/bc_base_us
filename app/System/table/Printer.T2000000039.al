// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Device;

/// <summary>
/// Virtual table that provides information about printers available to the system for report and document output.
/// This table enables printer discovery, selection, and management for printing operations.
/// </summary>
/// <remarks>
/// The Printer table provides access to printer resources available for document and report output.
/// It includes information about printer names, drivers, and capabilities that applications can use
/// to select appropriate printers for different types of output. This table is essential for
/// print management functionality, allowing users to choose specific printers for reports,
/// documents, and other printed materials. The table supports both local and network printers
/// accessible to the Business Central service, enabling flexible printing configurations
/// in various deployment scenarios.
/// </remarks>
table 2000000039 Printer
{
    DataPerCompany = False;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// The unique identifier for the printer in the system.
        /// </summary>
        field(1; ID; Text[250])
        {
        }
        /// <summary>
        /// The display name of the printer as shown to users.
        /// </summary>
        field(2; Name; Text[250])
        {
        }
        /// <summary>
        /// The printer driver name used by the system to communicate with the printer.
        /// </summary>
        field(3; Driver; Text[50])
        {
        }
        /// <summary>
        /// The device identifier or port information for the printer connection.
        /// </summary>
        field(4; Device; Text[50])
        {
        }

        /// <summary>
        /// The information about the printer.
        /// </summary>
        field(5; Payload; Text[2048])
        {
        }

        /// <summary>
        /// The representation of the printer.
        /// </summary>
        field(6; Description; Text[250])
        {
        }
    }

    keys
    {
        key(pk; ID)
        {

        }
    }
}