// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment.Configuration;

/// <summary>
/// Stores documentation links and help references for Business Central pages enabling context-sensitive help and user guidance.
/// </summary>
/// <remarks>
/// This table manages page-specific documentation mappings linking pages to their corresponding help content and documentation resources. Enables dynamic help system integration and context-aware user assistance. Used by the help system for providing relevant documentation based on user context and page navigation.
/// </remarks>
table 2000000198 "Page Documentation"
{
    Caption = 'Page Documentation';
    DataPerCompany = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Identifier of the Business Central page that has associated documentation content.
        /// </summary>
        field(1; "Page ID"; Integer)
        {
            Caption = 'Page ID';
        }
        /// <summary>
        /// Relative path or URL reference to the documentation content for the specified page.
        /// </summary>
        field(2; "Relative Path"; Text[250])
        {
            Caption = 'Relative Path';
        }
    }

    keys
    {
        key(Key1; "Page ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

