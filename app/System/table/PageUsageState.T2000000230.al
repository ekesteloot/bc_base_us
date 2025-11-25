// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment.Configuration;

/// <summary>
/// Stores user-specific page usage state and tour completion status for guided user experience features.
/// </summary>
/// <remarks>
/// This table tracks user interaction with pages, specifically tour and guided experience completion status.
/// Each record represents a user's state for a specific page, including whether tours have been dismissed or completed.
/// Essential for managing user onboarding experiences and preventing repeated display of completed tours.
/// </remarks>
table 2000000230 "Page Usage State"
{
    Caption = 'Page Usage State';
    DataPerCompany = false;
    Scope = OnPrem;
    ReplicateData = false;

    fields
    {
        /// <summary>
        /// The unique identifier of the user whose page usage state is tracked.
        /// </summary>
        field(1; "User ID"; Guid)
        {
            Caption = 'User ID';
        }
        /// <summary>
        /// The identifier of the page whose usage state is tracked.
        /// </summary>
        field(2; "Page ID"; Integer)
        {
            Caption = 'Object ID';
        }
        /// <summary>
        /// The type of page object whose usage state is tracked.
        /// </summary>
        field(3; "Page Type"; Option)
        {
            Caption = 'Object Type';
            OptionMembers = "Page","RequestPage","PageType","SystemPage";
            OptionCaption = 'Page,RequestPage,PageType,SystemPage';
        }
        /// <summary>
        /// Indicates whether the user has dismissed the tour for this page without completing it.
        /// </summary>
        field(4; "Tour Dismissed"; Boolean)
        {
            Caption = 'Tour Dismissed';
        }
        /// <summary>
        /// Indicates whether the user has completed the tour for this page.
        /// </summary>
        field(5; "Tour Completed"; Boolean)
        {
            Caption = 'Tour Completed';
        }
        /// <summary>
        /// Indicates whether the user has completed the system-level tour for this page type.
        /// </summary>
        field(6; "System Tour Completed"; Boolean)
        {
            Caption = 'System Tour Completed';
        }
    }

    keys
    {
        key(Key1; "User ID", "Page ID", "Page Type")
        {
            Clustered = true;
        }
    }
}
