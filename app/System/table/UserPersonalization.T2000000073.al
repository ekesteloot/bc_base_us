// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment.Configuration;

using System.Globalization;
using System.Reflection;
using System.Security.AccessControl;

/// <summary>
/// Stores user-specific personalization settings and preferences for the Business Central experience.
/// Manages individual user configurations including profiles, language settings, time zones, and customizations.
/// </summary>
/// <remarks>
/// This table centralizes user preference management across the tenant, supporting personalized user experiences
/// through profile assignments, localization settings, and interface customizations. Integrates with user management,
/// profile systems, and globalization frameworks for user experience configuration.
/// </remarks>
table 2000000073 "User Personalization"
{
    Caption = 'User Personalization';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// Unique security identifier of the user to whom these personalization settings apply.
        /// </summary>
        field(3; "User SID"; Guid)
        {
            Caption = 'User SID';
            TableRelation = User."User Security ID";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        /// <summary>
        /// Login name of the user (calculated from User table).
        /// </summary>
        field(6; "User ID"; Code[50])
        {
            CalcFormula = Lookup(User."User Name" WHERE("User Security ID" = FIELD("User SID")));
            Caption = 'User ID';
            FieldClass = FlowField;
        }
        /// <summary>
        /// Full display name of the user (calculated from User table).
        /// </summary>
        field(7; "Full Name"; Text[80])
        {
            Caption = 'Full Name';
            CalcFormula = Lookup(User."Full Name" WHERE("User Name" = FIELD("User ID")));
            FieldClass = FlowField;
        }
        /// <summary>
        /// Identifier of the user interface profile assigned to this user.
        /// </summary>
        field(9; "Profile ID"; Code[30])
        {
            Caption = 'Profile ID';
            TableRelation = "All Profile"."Profile ID";
        }
        /// <summary>
        /// Unique identifier of the extension application that provides the assigned profile.
        /// </summary>
        field(10; "App ID"; Guid)
        {
            Caption = 'App ID';
        }
        /// <summary>
        /// Scope level of the assigned profile (System or Tenant).
        /// </summary>
        field(11; Scope; Option)
        {
            // ObsoleteState = Pending;
            // ObsoleteReason = 'Support for System Profiles has been removed. All profiles are now in Tenant scope.';
            Caption = 'Scope';
            OptionCaption = 'System,Tenant';
            OptionMembers = System,Tenant;
        }
        /// <summary>
        /// Language identifier for the user's preferred interface language.
        /// </summary>
        field(12; "Language ID"; Integer)
        {
            Caption = 'Language ID';
        }
        /// <summary>
        /// Display name of the user's preferred language (calculated from Windows Language).
        /// </summary>
        field(13; "Language Name"; Text[80])
        {
            Caption = 'Language';
            CalcFormula = Lookup("Windows Language".Name WHERE("Language ID" = FIELD("Language ID")));
            FieldClass = FlowField;
        }
        /// <summary>
        /// Default company that the user will access when logging in.
        /// </summary>
        field(15; Company; Text[30])
        {
            Caption = 'Company';
            TableRelation = System.Environment.Company.Name;
        }
        /// <summary>
        /// Legacy debugger setting for break on error behavior (obsolete).
        /// </summary>
        field(18; "Debugger Break On Error"; Boolean)
        {
            Caption = 'Debugger Break On Error';
            InitValue = true;
            ObsoleteState = Removed;
            ObsoleteReason = 'Support for the classic debugger engine has been removed.';
        }
        /// <summary>
        /// Legacy debugger setting for break on record changes (obsolete).
        /// </summary>
        field(21; "Debugger Break On Rec Changes"; Boolean)
        {
            Caption = 'Debugger Break On Rec Changes';
            ObsoleteState = Removed;
            ObsoleteReason = 'Support for the classic debugger engine has been removed.';
        }
        /// <summary>
        /// Legacy debugger setting for skipping system triggers (obsolete).
        /// </summary>
        field(24; "Debugger Skip System Triggers"; Boolean)
        {
            Caption = 'Debugger Skip System Triggers';
            InitValue = true;
            ObsoleteState = Removed;
            ObsoleteReason = 'Support for the classic debugger engine has been removed.';
        }
        /// <summary>
        /// Locale identifier for regional formatting settings (dates, numbers, currency).
        /// </summary>
        field(27; "Locale ID"; Integer)
        {
            Caption = 'Locale ID';
        }
        /// <summary>
        /// Display name of the user's regional settings (calculated from Windows Language).
        /// </summary>
        field(28; Region; Text[80])
        {
            Caption = 'Region';
            CalcFormula = Lookup("Windows Language".Name WHERE("Language ID" = FIELD("Locale ID")));
            FieldClass = FlowField;
        }
        /// <summary>
        /// Time zone setting for the user's date and time display preferences.
        /// </summary>
        field(30; "Time Zone"; Text[180])
        {
            Caption = 'Time Zone';
        }
        /// <summary>
        /// License type assigned to the user (calculated from User table).
        /// </summary>
        field(31; "License Type"; Option)
        {
            CalcFormula = Lookup(User."License Type" WHERE("User Security ID" = FIELD("User SID")));
            Caption = 'License Type';
            FieldClass = FlowField;
            OptionCaption = 'Full User,Limited User,Device Only User,Windows Group,External User,External Administrator,External Accountant,Application,AAD Group,Agent';
            OptionMembers = "Full User","Limited User","Device Only User","Windows Group","External User","External Administrator","External Accountant","Application","AAD Group","Agent";
        }
        /// <summary>
        /// Internal status of user interface customizations and compilation state.
        /// </summary>
        field(32; "Customization Status"; Option)
        {
            Access = Internal;
            Caption = 'Customization Status';
            OptionCaption = 'Updated,Recompilation Needed,Recompilation Failed';
            OptionMembers = Updated,"Recompilation Needed","Recompilation Failed";
        }
        /// <summary>
        /// Display caption of the assigned user profile (calculated from All Profile).
        /// </summary>
        field(33; Role; Text[100])
        {
            Caption = 'Role';
            CalcFormula = Lookup("All Profile".Caption WHERE("Profile ID" = FIELD("Profile ID"), Scope = FIELD(Scope), "App ID" = FIELD("App ID")));
            FieldClass = FlowField;
        }
        /// <summary>
        /// Version number for tracking profile and customization compilation changes.
        /// </summary>
        field(34; "Emit Version"; Integer)
        {
            Caption = 'Emit Version';
        }
    }

    keys
    {
        key(Key1; "User SID")
        {
            Clustered = true;
        }
        key(Key2; "Profile ID")
        {
        }
        key(Key3; Company)
        {
        }
    }

    fieldgroups
    {
    }
}

