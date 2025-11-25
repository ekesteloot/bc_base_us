// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.IO;

/// <summary>
/// Virtual table that provides access to files and directories on the server file system.
/// This table enables file system operations including reading file information and accessing file contents.
/// </summary>
/// <remarks>
/// The File table provides server-side file system access capabilities for AL code that needs
/// to interact with files and directories. It enables operations such as file enumeration,
/// reading file properties, and accessing file contents through the Data field. This table
/// is only available in on-premises deployments where direct file system access is permitted.
/// Common use cases include data import/export operations, file processing, and integration
/// with external systems that use file-based data exchange. Security considerations apply
/// as this table provides access to the server's file system.
/// </remarks>
table 2000000022 "File"
{
    Scope = OnPrem;
    fields
    {
        /// <summary>
        /// The full path to the file or directory on the server file system.
        /// </summary>
        field(1; "Path"; Code[98])
        {
        }
        /// <summary>
        /// Indicates whether this record represents a file (true) or a directory (false).
        /// </summary>
        field(2; "Is a file"; Boolean)
        {
        }
        /// <summary>
        /// The name of the file or directory without the full path.
        /// </summary>
        field(3; "Name"; Text[99])
        {
        }
        /// <summary>
        /// The size of the file in bytes, or zero for directories.
        /// </summary>
        field(4; Size; Integer)
        {
        }
        /// <summary>
        /// The date when the file or directory was last modified.
        /// </summary>
        field(5; "Date"; Date)
        {
        }
        /// <summary>
        /// The time when the file or directory was last modified.
        /// </summary>
        field(6; "Time"; Time)
        {
        }
        /// <summary>
        /// The binary content of the file, available for files but not directories.
        /// </summary>
        field(7; "Data"; Blob)
        {
        }
    }

    keys
    {
        key(pk; "Path", "Is a file", "Name")
        {

        }
    }
}