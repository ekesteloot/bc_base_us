// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Reflection;

/// <summary>
/// Virtual table that provides metadata information about all XMLports in the system.
/// This table enables introspection of XMLport properties, data exchange configurations, and import/export characteristics.
/// </summary>
/// <remarks>
/// The XMLport Metadata table is essential for understanding XMLport definitions and their data exchange capabilities.
/// It includes detailed information about XMLport formats, encoding settings, transaction types, and directional
/// configurations for data import and export operations. This table is crucial for data integration management,
/// XML processing configuration, and administrative utilities that need to understand XMLport behaviors and
/// constraints. The information covers all XMLport types including XML, fixed text, and variable text formats,
/// providing visibility into the data exchange infrastructure across all applications.
/// </remarks>
table 2000000280 "XmlPort Metadata"
{
    DataPerCompany = False;
    Scope = Cloud;
    InherentPermissions = rX;

    fields
    {
        /// <summary>
        /// The unique identifier number of the XMLport.
        /// </summary>
        field(1; ID; Integer)
        {
        }
        /// <summary>
        /// The name of the XMLport as defined in the AL source code.
        /// </summary>
        field(2; Name; Text[30])
        {
        }
        /// <summary>
        /// The caption text displayed for this XMLport in the user interface.
        /// </summary>
        field(3; Caption; Text[80])
        {
        }
        /// <summary>
        /// Indicates whether the XMLport displays a request page for parameter input before execution.
        /// </summary>
        field(4; UseRequestPage; Boolean)
        {
        }
        /// <summary>
        /// The transaction type used for database operations during XMLport execution.
        /// </summary>
        field(5; TransactionType; Option)
        {
            OptionMembers = UpdateNoLocks,Update,Snapshot,Browse,Report;
        }
        /// <summary>
        /// The data flow direction supported by the XMLport (Import, Export, or Both).
        /// </summary>
        field(6; Direction; Option)
        {
            OptionMembers = Import,Export,Both;
        }
        /// <summary>
        /// The character encoding used for XML data processing.
        /// </summary>
        field(7; Encoding; Option)
        {
            OptionMembers = UTF8,UTF16,ISO88592;
        }
        /// <summary>
        /// The text encoding used for text-based data formats.
        /// </summary>
        field(8; TextEncoding; Option)
        {
            OptionMembers = MSDos,UTF8,UTF16,Windows;
        }
        /// <summary>
        /// The data format type supported by the XMLport (XML, Variable Text, or Fixed Text).
        /// </summary>
        field(9; Format; Option)
        {
            OptionMembers = Xml,VariableText,FixedText;
        }
        /// <summary>
        /// The application identifier that contains this XMLport.
        /// </summary>
        field(10; "App ID"; Guid)
        {
        }
        /// <summary>
        /// The inherent permissions defined for this XMLport (Read, Insert, Modify, Delete).
        /// </summary>
        field(11; InherentPermissions; Text[5])
        {
        }
        /// <summary>
        /// The inherent entitlements required to access this XMLport.
        /// </summary>
        field(12; InherentEntitlements; Text[5])
        {
        }
    }

    fieldgroups
    {
        fieldgroup("DropDown"; ID, Caption)
        {
        }
    }
}