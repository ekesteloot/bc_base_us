// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Security.AccessControl;

/// <summary>
/// Virtual table that provides a mapping between Windows Security Identifiers (SIDs) and account identifiers.
/// </summary>
/// <remarks>
/// This table enables lookup and translation between Windows SIDs and corresponding account IDs in the system.
/// Essential for security and access control scenarios where SID-to-account mapping is required.
/// Used by authentication and authorization processes to resolve user identities from Windows security tokens.
/// The table is scoped to OnPrem and not per-company, reflecting its system-wide security role.
/// </remarks>
table 2000000055 "SID - Account ID"
{
    DataPerCompany = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// The Windows Security Identifier (SID) in string format.
        /// </summary>
        field(1; SID; text[118])
        {
        }
        /// <summary>
        /// The corresponding account identifier or username associated with the SID.
        /// </summary>
        field(2; ID; text[130])
        {
        }
    }

    keys
    {
        key(pk; SID)
        {

        }
        key(fk; ID)
        {

        }
    }
}