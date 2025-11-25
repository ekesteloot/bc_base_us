// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment.Configuration;

/// <summary>
/// Stores designer created extensions for application profiles.
/// </summary>
/// <remarks>
/// This table contains customized profile extensions that modify or extend base profile functionality.
/// Includes metadata, custom AL code, and compilation status tracking for updating the metadata when the target profile or its customized page are changing.
/// Data is not company-specific to ensure consistent profile extensions across the tenant.
/// </remarks>
table 2000000084 "Tenant Profile Extension"
{
    Caption = 'Tenant Profile Extension';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Application identifier that owns this profile extension, used for app-specific customization management.
        /// </summary>
        field(1; "App ID"; Guid)
        {
            Caption = 'App ID';
        }
        /// <summary>
        /// Application identifier of the base profile being extended, establishing the inheritance relationship.
        /// </summary>
        field(2; "Base Profile App ID"; Guid)
        {
            Caption = 'Base Profile App ID';
        }
        /// <summary>
        /// Identifier of the base profile being extended, uniquely identifying the source profile for customization.
        /// </summary>
        field(3; "Base Profile ID"; Code[30])
        {
            Caption = 'Base Profile ID';
        }
        /// <summary>
        /// Binary metadata describing the profile extension configuration, including customization rules and settings.
        /// </summary>
        field(4; Metadata; BLOB)
        {
            Caption = 'Metadata';
        }
        /// <summary>
        /// Custom AL code written by users for this profile extension, stored as binary data for compilation and execution.
        /// </summary>
        field(5; "User AL Code"; BLOB)
        {
            Caption = 'User AL Code';
        }
        /// <summary>
        /// Version number of the compilation emit process, used for tracking compilation iterations and changes.
        /// </summary>
        field(6; "Emit Version"; Integer)
        {
            Caption = 'Emit Version';
        }
        /// <summary>
        /// Current status of the profile extension customization, indicating whether compilation is needed or has failed.
        /// </summary>
        field(7; "Customization Status"; Option)
        {
            Access = Internal;
            Caption = 'Customization Status';
            OptionCaption = 'Updated,Recompilation Needed,Recompilation Failed';
            OptionMembers = Updated,"Recompilation Needed","Recompilation Failed";
        }
    }

    keys
    {
        key(Key1; "App ID", "Base Profile App ID", "Base Profile ID")
        {
            Clustered = true;
        }

        key(Key2; "Base Profile App ID", "Base Profile ID")
        {
        }
    }

    fieldgroups
    {
    }
}

