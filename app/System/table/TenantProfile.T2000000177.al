// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment.Configuration;

using System.Reflection;

/// <summary>
/// Contains the profiles created using the in-client profile configuration.
/// </summary>
/// <remarks>
/// Profiles from extensions are stored as resources in the [Application Resource] table.
/// The list of all profiles can be accessed using the [All Profile] virtual table.
/// </remarks>
table 2000000177 "Tenant Profile"
{
    Caption = 'Tenant Profile';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;
    InherentPermissions = RX;

    fields
    {
        /// <summary>
        /// Application identifier that owns this tenant profile, used for app-specific profile management and customization.
        /// </summary>
        field(1; "App ID"; Guid)
        {
            Caption = 'App ID';
        }
        /// <summary>
        /// Unique identifier for the profile within the application, used to reference and manage profile configurations.
        /// </summary>
        field(2; "Profile ID"; Code[30])
        {
            Caption = 'Profile ID';
        }
        /// <summary>
        /// Human-readable description of the profile, stored in metadata field for better profile identification (pending obsolescence).
        /// </summary>
        field(3; Description; Text[250])
        {
            Caption = 'Description';
            ObsoleteReason = 'Stored in the Metadata field of the Tenant Profile table.';
            ObsoleteState = Pending;
        }
        /// <summary>
        /// Page identifier for the role center associated with this profile, stored in metadata field for better management (pending obsolescence).
        /// </summary>
        field(4; "Role Center ID"; Integer)
        {
            Caption = 'Role Center ID';
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Page));
            ObsoleteReason = 'Stored in the Metadata field of the Tenant Profile table.';
            ObsoleteState = Pending;
        }
        /// <summary>
        /// Indicates if this profile is the default role center, moved to Tenant Profile Setting table (pending obsolescence).
        /// </summary>
        field(5; "Default Role Center"; Boolean)
        {
            Caption = 'Default Role Center';
            ObsoleteReason = 'Moved to the Tenant Profile Setting table.';
            ObsoleteState = Pending;
        }
        /// <summary>
        /// Controls whether personalization is disabled for this profile, moved to Tenant Profile Setting table (pending obsolescence).
        /// </summary>
        field(6; "Disable Personalization"; Boolean)
        {
            Caption = 'Disable Personalization';
            ObsoleteReason = 'Moved to the Tenant Profile Setting table.';
            ObsoleteState = Pending;
        }
        /// <summary>
        /// Binary metadata containing the profile configuration settings, descriptions, and structural information.
        /// </summary>
        field(7; Metadata; BLOB)
        {
            Caption = 'Metadata';
        }
        /// <summary>
        /// Custom AL code written by users for this profile, stored as binary data for compilation and execution.
        /// </summary>
        field(8; "User AL Code"; BLOB)
        {
            Caption = 'User AL Code';
        }
        /// <summary>
        /// Internal status of the profile customization, indicating whether compilation is needed or has failed.
        /// </summary>
        field(9; "Customization Status"; Option)
        {
            Access = Internal;
            Caption = 'Customization Status';
            OptionCaption = 'Updated,Recompilation Needed,Recompilation Failed';
            OptionMembers = Updated,"Recompilation Needed","Recompilation Failed";
        }
        /// <summary>
        /// Version number of the compilation emit process, used for tracking profile compilation iterations and changes.
        /// </summary>
        field(10; "Emit Version"; Integer)
        {
            Caption = 'Emit Version';
        }
    }

    keys
    {
        key(Key1; "App ID", "Profile ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

