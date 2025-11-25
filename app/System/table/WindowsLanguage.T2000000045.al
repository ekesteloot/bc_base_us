// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Globalization;

/// <summary>
/// Virtual table that provides information about available Windows languages and their localization capabilities.
/// This table enables language selection, localization management, and multi-language application support.
/// </summary>
/// <remarks>
/// The Windows Language table is fundamental for multi-language Business Central deployments, providing
/// information about available languages, their characteristics, and localization assets.
/// It includes details about language enablement for different object types, code page information,
/// and the availability of localization files. This table is essential for language selection in user
/// interfaces, report generation in different languages, and managing localized content. The information
/// supports both user language preferences and system-wide language configuration, enabling global
/// deployments with proper localization support.
/// </remarks>
table 2000000045 "Windows Language"
{
    Scope = Cloud;
    InherentPermissions = RX;

    fields
    {
        /// <summary>
        /// The unique Windows language identifier used by the system for language operations.
        /// </summary>
        field(1; "Language ID"; Integer)
        {
        }
        /// <summary>
        /// The primary language identifier for languages that have multiple variants or regions.
        /// </summary>
        field(2; "Primary Language ID"; Integer)
        {
        }
        /// <summary>
        /// The full name of the language as displayed to users.
        /// </summary>
        field(10; Name; Text[80])
        {
        }
        /// <summary>
        /// The abbreviated language code (e.g., "EN", "FR", "DE") for compact language representation.
        /// </summary>
        field(11; "Abbreviated Name"; Text[3])
        {
        }
        /// <summary>
        /// Indicates whether the language is currently enabled and available for use in the system.
        /// </summary>
        field(20; Enabled; Boolean)
        {
        }
        /// <summary>
        /// Indicates whether the language is enabled globally across all companies and environments.
        /// </summary>
        field(21; "Globally Enabled"; Boolean)
        {
        }
        /// <summary>
        /// Indicates whether the language is enabled for form and page display.
        /// </summary>
        field(22; "Form Enabled"; Boolean)
        {
        }
        /// <summary>
        /// Indicates whether the language is enabled for report generation and output.
        /// </summary>
        field(23; "Report Enabled"; Boolean)
        {
        }
        /// <summary>
        /// Indicates whether the language is enabled for legacy dataport operations.
        /// </summary>
        field(24; "Dataport Enabled"; Boolean)
        {
        }
        /// <summary>
        /// Indicates whether the language is enabled for XMLport data exchange operations.
        /// </summary>
        field(25; "XMLport Enabled"; Boolean)
        {
        }
        /// <summary>
        /// The primary code page used for character encoding in this language.
        /// </summary>
        field(30; "Primary CodePage"; Text[5])
        {
        }
        /// <summary>
        /// Indicates whether the STX (String Text) file exists for this language's localization.
        /// </summary>
        field(31; "STX File Exist"; Boolean)
        {
        }
        /// <summary>
        /// Indicates whether the ETX (Extended Text) file exists for this language's localization.
        /// </summary>
        field(32; "ETX File Exist"; Boolean)
        {
        }
        /// <summary>
        /// Indicates whether help files are available in this language.
        /// </summary>
        field(33; "Help File Exist"; Boolean)
        {
        }
        /// <summary>
        /// Indicates whether complete localization resources exist for this language.
        /// </summary>
        field(34; "Localization Exist"; Boolean)
        {
        }
        /// <summary>
        /// The IETF language tag (RFC 5646) for this language, used in modern web and API contexts.
        /// </summary>
        field(35; "Language Tag"; Text[80]) // https://www.w3.org/International/articles/language-tags/
        {
        }
    }

    keys
    {
        key(pk; "Language ID")
        {
        }
        key(fk1; "Primary Language ID", "Language ID")
        {
        }
        key(fk2; Name)
        {
        }
        key(fk3; "Abbreviated Name")
        {
        }
        key(fk4; "Language Tag")
        {
        }
    }
}