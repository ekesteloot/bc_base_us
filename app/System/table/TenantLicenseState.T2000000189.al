// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Security.AccessControl;

/// <summary>
/// Tracks the licensing state and validity periods for Business Central tenants, managing license transitions and access control.
/// </summary>
/// <remarks>
/// This table maintains the license state history for tenants, tracking different licensing phases such as evaluation,
/// trial, paid, warning, suspended, and deleted states. Each record represents a license period with start and end dates,
/// enabling the system to manage license transitions and enforce access restrictions based on licensing status.
/// Used by the licensing framework to control tenant access and enforce license compliance.
/// </remarks>
table 2000000189 "Tenant License State"
{
    Caption = 'Tenant License State';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = Cloud;
    InherentPermissions = rX;

    fields
    {
        /// <summary>
        /// Start date and time when this license state becomes effective.
        /// </summary>
        field(1; "Start Date"; DateTime)
        {
            Caption = 'Start Date';
        }
        /// <summary>
        /// End date and time when this license state expires.
        /// </summary>
        field(2; "End Date"; DateTime)
        {
            Caption = 'End Date';
        }
        /// <summary>
        /// Current licensing state of the tenant defining access permissions and restrictions.
        /// </summary>
        field(3; State; Option)
        {
            Caption = 'State';
            OptionCaption = 'Evaluation,Trial,Paid,Warning,Suspended,Deleted,,,,LockedOut';
            OptionMembers = Evaluation,Trial,Paid,Warning,Suspended,Deleted,,,,LockedOut;
        }
        /// <summary>
        /// Security ID of the user associated with this license state record.
        /// </summary>
        field(4; "User Security ID"; Guid)
        {
            Caption = 'User Security ID';
            TableRelation = User."User Security ID";
        }
    }

    keys
    {
        key(Key1; "Start Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

