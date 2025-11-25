// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Apps;

/// <summary>
/// Stores archived data from tables when apps are uninstalled, preserving data for potential restoration.
/// </summary>
/// <remarks>
/// This table manages archived table data that is preserved when Business Central apps are uninstalled.
/// Each record represents archived data from a specific table and app version, including metadata for restoration purposes.
/// Essential for data preservation during app lifecycle management, enabling data recovery when apps are reinstalled.
/// </remarks>
table 2000000152 "NAV App Data Archive"
{
    Caption = 'NAV App Data Archive';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// The unique identifier of the app whose data is archived.
        /// </summary>
        field(1; "App ID"; Guid)
        {
            Caption = 'App ID';
        }
        /// <summary>
        /// The identifier of the table whose data is archived.
        /// </summary>
        field(2; "Table ID"; Integer)
        {
            Caption = 'Table ID';
        }
        /// <summary>
        /// The name of the company whose data is archived.
        /// </summary>
        field(3; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
        }
        /// <summary>
        /// The major version number of the app when the data was archived.
        /// </summary>
        field(4; "Version Major"; Integer)
        {
            Caption = 'Version Major';
        }
        /// <summary>
        /// The minor version number of the app when the data was archived.
        /// </summary>
        field(5; "Version Minor"; Integer)
        {
            Caption = 'Version Minor';
        }
        /// <summary>
        /// The build version number of the app when the data was archived.
        /// </summary>
        field(6; "Version Build"; Integer)
        {
            Caption = 'Version Build';
        }
        /// <summary>
        /// The revision version number of the app when the data was archived.
        /// </summary>
        field(7; "Version Revision"; Integer)
        {
            Caption = 'Version Revision';
        }
        /// <summary>
        /// The name of the archive table where the actual data is stored.
        /// </summary>
        field(8; "Archive Table Name"; Text[128])
        {
            Caption = 'Archive Table Name';
        }
        /// <summary>
        /// The metadata information for the archived table structure.
        /// </summary>
        field(9; Metadata; BLOB)
        {
            Caption = 'Metadata';
        }
        /// <summary>
        /// The version number of the table blob, indicating the structure version of the archived data.
        /// </summary>
        field(10; "Table Blob Version"; Integer)
        {
            Caption = 'Table Blob Version';
        }
    }

    keys
    {
        key(Key1; "App ID", "Table ID", "Company Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

