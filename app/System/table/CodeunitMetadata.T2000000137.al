// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Reflection;

/// <summary>
/// Virtual table that provides metadata information about codeunits in the system.
/// </summary>
/// <remarks>
/// This table exposes metadata about codeunits including their properties, subtype,
/// permissions, and application associations. Essential for reflection scenarios, development tools,
/// and runtime analysis of codeunit characteristics. Used by the platform to determine codeunit
/// capabilities such as single instance behavior, test classifications, and security permissions.
/// The table provides read-only access to codeunit metadata across all installed applications.
/// </remarks>
table 2000000137 "CodeUnit Metadata"
{
    DataPerCompany = False;
    Scope = Cloud;
    InherentPermissions = rX;

    fields
    {
        /// <summary>
        /// The unique identifier of the codeunit.
        /// </summary>
        field(1; ID; Integer)
        {
        }
        /// <summary>
        /// The name of the codeunit as defined in AL code.
        /// </summary>
        field(2; Name; Text[30])
        {
        }
        /// <summary>
        /// The table number if this codeunit is associated with a specific table.
        /// </summary>
        field(3; TableNo; Integer)
        {
        }
        /// <summary>
        /// Indicates whether this codeunit is defined as a single instance codeunit.
        /// </summary>
        field(4; SingleInstance; Boolean)
        {
        }
        /// <summary>
        /// The subtype classification of the codeunit (Normal, Test, TestRunner, or Upgrade).
        /// </summary>
        field(5; SubType; Option)
        {
            OptionMembers = Normal,Test,TestRunner,Upgrade;
        }
        /// <summary>
        /// The application ID that contains this codeunit.
        /// </summary>
        field(6; "App ID"; Guid)
        {
        }
        /// <summary>
        /// The inherent permissions defined for this codeunit.
        /// </summary>
        field(7; InherentPermissions; Text[5])
        {
        }
        /// <summary>
        /// The inherent entitlements defined for this codeunit.
        /// </summary>
        field(8; InherentEntitlements; Text[5])
        {
        }
        /// <summary>
        /// The test type classification when this is a test codeunit.
        /// </summary>
        field(9; TestType; Option)
        {
            OptionMembers = None,UnitTest,IntegrationTest,Uncategorized,AITest;
        }
        field(10; RequiredTestIsolation; Option)
        {
            OptionMembers = None,Disabled,Codeunit,Function;
        }
        /// <summary>
        /// The AL namespace of the object.
        /// </summary>
        field(11; "AL Namespace"; text[500])
        {
            
        }
    }

    keys
    {
        key(pk; ID)
        {

        }
    }

    fieldgroups
    {
        fieldgroup("DropDown"; ID, Name, "AL Namespace")
        {
        }
    }
}