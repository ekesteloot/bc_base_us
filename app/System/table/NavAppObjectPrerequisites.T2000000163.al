// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Apps;

/// <summary>
/// Manages object-level prerequisites and dependencies for published applications ensuring compatibility verification.
/// Tracks specific objects required by applications for proper installation and runtime execution.
/// </summary>
/// <remarks>
/// This table stores metadata about objects that published applications depend on for proper functionality. Used by the application management system for dependency validation during installation and upgrade processes. Supports prerequisite checking for various object types including tables, reports, codeunits, pages, and queries.
/// </remarks>
table 2000000163 "NAV App Object Prerequisites"
{
    Caption = 'NAV App Object Prerequisites';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Package identifier of the application that has the prerequisite requirement.
        /// </summary>
        field(1; "Package ID"; Guid)
        {
            Caption = 'Package ID';
        }
        /// <summary>
        /// Type of Business Central object required as a prerequisite for the application.
        /// </summary>
        field(2; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'TableData,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query';
            OptionMembers = TableData,"Table",,"Report",,"Codeunit","XMLport",MenuSuite,"Page","Query";
        }
        /// <summary>
        /// Unique identifier of the prerequisite object within its type category.
        /// </summary>
        field(3; ID; Integer)
        {
            Caption = 'ID';
        }
    }

    keys
    {
        key(Key1; "Package ID", Type, ID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

