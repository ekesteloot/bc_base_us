// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment.Configuration;

using System.Security.AccessControl;

/// <summary>
/// Stores user-specific page data personalizations and customizations for individual user experiences.
/// Manages personalized settings, filters, and data preferences that users apply to pages and reports.
/// </summary>
/// <remarks>
/// This table enables users to save and restore personalized data views, column settings, and filtering
/// preferences for pages and reports. Integrates with personalization frameworks, user interface
/// customization systems, and profile-based experience management for enhanced user productivity.
/// </remarks>
table 2000000080 "Page Data Personalization"
{
    Caption = 'Page Data Personalization';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// Security identifier of the user who owns this personalization setting, linking personalizations to specific users.
        /// </summary>
        field(3; "User SID"; Guid)
        {
            Caption = 'User SID';
            TableRelation = User."User Security ID";
        }
        /// <summary>
        /// Human-readable user name associated with the personalization, calculated from the User table for display purposes.
        /// </summary>
        field(6; "User ID"; Code[50])
        {
            CalcFormula = Lookup(User."User Name" WHERE("User Security ID" = FIELD("User SID")));
            Caption = 'User ID';
            FieldClass = FlowField;
        }
        /// <summary>
        /// Type of object (Report, XMLport, or Page) for which the personalization applies, determining the personalization context.
        /// </summary>
        field(9; "Object Type"; Option)
        {
            Caption = 'Object Type';
            OptionMembers = ,,,"Report",,,"XMLport",,"Page",,,,,,,,,,,;
            OptionCaption = ',,,Report,,,XMLport,,Page,,,,,,,,,,,';
        }
        /// <summary>
        /// Unique identifier of the specific object (report, XMLport, or page) that has been personalized by the user.
        /// </summary>
        field(12; "Object ID"; Integer)
        {
            Caption = 'Object ID';
            TableRelation = System.Reflection.Object.ID WHERE(Type = FIELD("Object Type"));
        }
        /// <summary>
        /// Date when this personalization setting was created or last modified, used for tracking and maintenance purposes.
        /// </summary>
        field(15; Date; Date)
        {
            Caption = 'Date';
        }
        /// <summary>
        /// Time when this personalization setting was created or last modified, providing detailed timestamp information.
        /// </summary>
        field(18; Time; Time)
        {
            Caption = 'Time';
        }
        /// <summary>
        /// Unique identifier for the personalization instance, allowing multiple personalization settings per object and user combination.
        /// </summary>
        field(21; "Personalization ID"; Code[40])
        {
            Caption = 'Personalization ID';
        }
        /// <summary>
        /// Name of the specific personalization value or setting type, identifying what aspect of the object is being personalized.
        /// </summary>
        field(24; ValueName; Code[40])
        {
            Caption = 'ValueName';
        }
        /// <summary>
        /// Binary data containing the actual personalization configuration and settings applied by the user.
        /// </summary>
        field(27; Value; BLOB)
        {
            Caption = 'Value';
        }
    }

    keys
    {
        key(Key1; "User SID", "Object Type", "Object ID", "Personalization ID", ValueName)
        {
            Clustered = true;
        }
        key(Key2; Date)
        {
        }
    }

    fieldgroups
    {
    }
}

