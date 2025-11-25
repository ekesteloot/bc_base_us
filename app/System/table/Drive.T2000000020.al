// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.IO;

/// <summary>
/// Virtual table that provides information about disk drives available on the server system.
/// This table enables monitoring of storage capacity and space availability for system administration.
/// </summary>
/// <remarks>
/// The Drive table provides essential disk space monitoring capabilities for on-premises deployments
/// where administrators need visibility into server storage resources. It shows information about
/// all drives accessible to the Business Central server, including their size, available space,
/// and whether they are removable media. This information is valuable for system monitoring,
/// storage planning, and ensuring adequate disk space for operations such as backups, data exports,
/// and temporary file operations. The table is only available in on-premises environments where
/// direct access to the server file system is permitted.
/// </remarks>
table 2000000020 Drive
{
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// The drive letter identifier (e.g., "C:", "D:") for the disk drive.
        /// </summary>
        field(1; Drive; Code[2])
        {
        }
        /// <summary>
        /// Indicates whether the drive represents removable media such as a CD-ROM, USB drive, or floppy disk.
        /// </summary>
        field(2; Removable; Boolean)
        {
        }
        /// <summary>
        /// The total storage capacity of the drive, measured in kilobytes.
        /// </summary>
        field(3; "Size (KB)"; Integer)
        {
        }
        /// <summary>
        /// The amount of free space available on the drive, measured in kilobytes.
        /// </summary>
        field(4; "Free (KB)"; Integer)
        {
        }
    }

    keys
    {
        key(pk; Drive)
        {

        }
    }
}