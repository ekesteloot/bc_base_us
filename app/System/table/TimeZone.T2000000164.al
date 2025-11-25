// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.DateTime;

/// <summary>
/// Virtual table that provides information about available time zones for date and time calculations.
/// This table enables time zone-aware operations and supports international deployments with multiple time zones.
/// </summary>
/// <remarks>
/// The Time Zone table provides access to system-defined time zones that can be used for converting
/// between different time zones and handling date/time operations in global applications. This table
/// is essential for applications that need to display times in different time zones, schedule operations
/// across regions, or handle user preferences for time zone display. The table includes standard
/// time zone identifiers and their user-friendly display names, enabling both programmatic access
/// and user interface presentation of time zone information.
/// </remarks>
table 2000000164 "Time Zone"
{
    DataPerCompany = False;
    Scope = Cloud;
    InherentPermissions = RX;

    fields
    {
        /// <summary>
        /// The unique time zone identifier string used by the system for time zone operations.
        /// </summary>
        field(1; ID; Text[180])
        { //TODO
        }
        /// <summary>
        /// The user-friendly display name of the time zone, typically including the region and standard time designation.
        /// </summary>
        field(2; "Display Name"; Text[250])
        {
        }
        /// <summary>
        /// The sequential number assigned to this time zone for indexing and sorting purposes.
        /// </summary>
        field(3; "No."; Integer)
        {
        }
    }

    keys
    {
        key(pk; "No.")
        {

        }
        key(fk; "Display Name")
        {

        }
    }
}