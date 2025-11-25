// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Tooling;

/// <summary>
/// Virtual table that provides code coverage analysis data for AL objects during testing and debugging.
/// This table enables tracking of code execution patterns and identifying untested code paths.
/// </summary>
/// <remarks>
/// The Code Coverage table is essential for development and testing workflows, providing detailed
/// line-by-line execution tracking for AL code. It records which lines of code have been executed
/// during test runs or debugging sessions, helping developers identify untested code paths and
/// measure test coverage quality. This table supports quality assurance processes by highlighting
/// areas of code that may need additional testing. The information is particularly valuable for
/// automated testing frameworks, code quality analysis, and ensuring test coverage
/// across all AL objects in an application.
/// </remarks>
table 2000000049 "Code Coverage"
{
    DataPerCompany = false;
    Scope = Cloud;
    fields
    {
        /// <summary>
        /// The type of AL object being tracked for code coverage.
        /// </summary>
        field(1; "Object Type"; Option)
        {
            OptionMembers = ,"Table",,"Report",,"Codeunit","XMLport",,"Page","Query",,,,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension","PermissionSet","PermissionSetExtension","ReportExtension";
            OptionCaption = ',Table,,Report,,Codeunit,XMLport,,Page,Query,,,,,PageExtension,TableExtension,Enum,EnumExtension,Profile,ProfileExtension,PermissionSet,PermissionSetExtension,ReportExtension';
        }
        /// <summary>
        /// The unique identifier of the object being tracked for code coverage.
        /// </summary>
        field(2; "Object ID"; Integer)
        {
        }
        /// <summary>
        /// The line number within the object's source code.
        /// </summary>
        field(3; "Line No."; Integer)
        {
        }
        /// <summary>
        /// The type of code line (Object declaration, Trigger/Function, Empty line, or executable Code).
        /// </summary>
        field(4; "Line Type"; Option)
        {
            OptionMembers = Object,"Trigger/Function",Empty,Code;
        }
        /// <summary>
        /// The actual source code text of the line being tracked.
        /// </summary>
        field(5; Line; Text[250])
        {
        }
        /// <summary>
        /// The number of times this line of code has been executed during the coverage tracking session.
        /// </summary>
        field(6; "No. of Hits"; Integer)
        {
        }
        /// <summary>
        /// The coverage status indicating whether the line was executed, partially executed, or not covered.
        /// </summary>
        field(7; "Code Coverage Status"; Option)
        {
            OptionMembers = NonApplicable,NotCovered,Covered,PartiallyCovered;
            OptionCaption = 'Non Applicable,Not Covered,Covered,Partially Covered';
        }
        field(8; "Method Id"; Integer)
        {
        }
    }
    keys
    {
        key(pk; "Object Type", "Object ID", "Line No.")
        {
        }
    }
}
