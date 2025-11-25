// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Integration;

/// <summary>
/// Stores configuration for external programs that can receive data from Business Central through send-to operations and document export functionality.
/// </summary>
/// <remarks>
/// This table manages external application integration configurations enabling users to send reports, documents, and data to external programs with custom parameters. Supports executable path configuration and parameter passing for flexible external system integration. Used by the platform for document export and external application launching.
/// </remarks>
table 2000000065 "Send-To Program"
{
    Caption = 'Send-To Program';
    DataPerCompany = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Unique identifier for the external program configuration used for referencing and management operations.
        /// </summary>
        field(1; "Program ID"; Guid)
        {
            Caption = 'Program ID';
        }
        /// <summary>
        /// File path and executable name for the external program that will receive data from Business Central.
        /// </summary>
        field(2; Executable; Text[250])
        {
            Caption = 'Executable';
        }
        /// <summary>
        /// Command-line parameters and arguments to pass to the external program during invocation.
        /// </summary>
        field(3; Parameter; Text[250])
        {
            Caption = 'Parameter';
        }
        /// <summary>
        /// Descriptive name for the external program used for identification and selection in user interfaces.
        /// </summary>
        field(4; Name; Text[250])
        {
            Caption = 'Name';
        }
    }

    keys
    {
        key(Key1; "Program ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

