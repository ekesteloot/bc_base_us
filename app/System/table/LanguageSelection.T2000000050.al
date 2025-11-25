// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Globalization;

/// <summary>
/// Virtual table that provides language selection options and configuration for user interface localization.
/// This table enables users to choose their preferred language for the Business Central interface.
/// </summary>
/// <remarks>
/// The Language Selection table provides language options available for user interface localization
/// in Business Central. It enables users to select their preferred language for menus, captions,
/// and other UI elements. This table is essential for multi-language deployments where users
/// need to work in different languages. The table includes information about enabled languages,
/// their identifiers, and regional variations. It supports both global language settings and
/// user-specific language preferences, enabling flexible localization configurations that
/// accommodate diverse international user bases.
/// </remarks>
table 2000000050 "Language Selection"
{
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// The full name of the language as displayed in language selection interfaces.
        /// </summary>
        field(1; Name; Text[80])
        {
            Caption = 'Name';
        }
        /// <summary>
        /// The unique Windows language identifier for this language.
        /// </summary>
        field(2; "Language ID"; Integer)
        {
            Caption = 'Language';
        }
        /// <summary>
        /// The primary language identifier for languages that have multiple regional variants.
        /// </summary>
        field(3; "Primary Language ID"; Integer)
        {
            Caption = 'Primary Langueage';
        }
        /// <summary>
        /// The abbreviated language code for compact display and identification.
        /// </summary>
        field(4; "Abbreviated Name"; Text[3])
        {
            Caption = 'Abbreviated Name';
        }
        /// <summary>
        /// Indicates whether this language option is currently enabled and available for selection.
        /// </summary>
        field(5; Enabled; Boolean)
        {
            Caption = 'Enabled';
        }
        /// <summary>
        /// The IETF language tag identifying the language and regional variant.
        /// </summary>
        field(6; "Language Tag"; Text[80]) // https://www.w3.org/International/articles/language-tags/
        {
            Caption = 'Region';
        }
    }

    keys
    {
        key(pk; Name, "Language Tag", "Language ID")
        {
        }
        key(key1; "Enabled")
        {
        }
    }
}