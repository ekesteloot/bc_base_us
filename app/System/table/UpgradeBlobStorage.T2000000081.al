// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Upgrade;

/// <summary>
/// Stores binary content and files used during application upgrade processes including transformation scripts and temporary data storage.
/// </summary>
/// <remarks>
/// This table manages upgrade-related binary assets including data transformation scripts, temporary files, and upgrade artifacts. Provides temporary storage for complex upgrade operations requiring file-based processing or external tool integration. Used by the upgrade system for managing upgrade assets and intermediate processing files.
/// </remarks>
table 2000000081 "Upgrade Blob Storage"
{
    Caption = 'Upgrade Blob Storage';
    DataPerCompany = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Unique code identifier for the upgrade blob storage item used for referencing and retrieval operations.
        /// </summary>
        field(1; "Code"; Code[50])
        {
            Caption = 'Code';
        }
        /// <summary>
        /// Binary content containing upgrade files, scripts, or data used during upgrade processing operations.
        /// </summary>
        field(2; Blob; BLOB)
        {
            Caption = 'Blob';
        }
        /// <summary>
        /// File extension indicating the type and format of the stored binary content for proper processing.
        /// </summary>
        field(3; "File Extension"; Text[10])
        {
            Caption = 'File Extension';
        }
        /// <summary>
        /// Descriptive text explaining the purpose and content of the upgrade blob storage item.
        /// </summary>
        field(4; Description; Text[250])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

