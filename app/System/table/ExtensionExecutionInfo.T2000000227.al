// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Tooling;

/// <summary>
/// Virtual table that provides execution performance information for extensions.
/// </summary>
/// <remarks>
/// This table exposes runtime performance metrics for extension execution, including timing data
/// and subscriber execution counts. Essential for performance monitoring, optimization analysis,
/// and identifying extensions that may be impacting system performance. Used by administrators
/// and developers to analyze extension behavior and optimize performance in production environments.
/// The table is scoped to OnPrem and not replicated for performance and security considerations.
/// </remarks>
table 2000000227 "Extension Execution Info"
{
    Caption = 'Extension Execution Info';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// The unique identifier of the form or UI context where the extension was executed.
        /// </summary>
        field(1; "Form ID"; Guid)
        {
            Caption = 'Form ID';
        }

        /// <summary>
        /// The runtime package ID of the extension that was executed.
        /// </summary>
        field(2; "Runtime Package ID"; Guid)
        {
            Caption = 'Runtime Package ID';
        }

        /// <summary>
        /// The total execution time for the extension, measured in milliseconds.
        /// </summary>
        field(3; "Execution Time"; Integer)
        {
            Caption = 'Execution time';
        }

        /// <summary>
        /// The number of times extension subscribers were executed during this measurement period.
        /// </summary>
        field(4; "Subscriber Execution Count"; Integer)
        {
            Caption = 'Subscriber execution count';
        }
    }

    keys
    {
        key(PK; "Form ID", "Runtime Package ID")
        {
            Clustered = true;
        }
    }
}