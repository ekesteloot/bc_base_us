// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment.Configuration;

using System.Security.AccessControl;

/// <summary>
/// Stores user-specific default style sheet selections for reports and pages, enabling personalized UI appearance and formatting preferences.
/// This table manages individual user customizations for object styling across different programs and contexts.
/// </summary>
/// <remarks>
/// This table maintains user-specific style sheet preferences for different object types and programs.
/// Each record defines the default style sheet for a specific user, object, and program combination.
/// Data is not company-specific to ensure consistent user experience across companies.
/// Extensibility points include custom style sheet selection logic and theme inheritance rules.
/// Related functionality: User interface customization, style sheet management, and personalization framework.
/// </remarks>
table 2000000067 "User Default Style Sheet"
{
    Caption = 'User Default Style Sheet';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// Security identifier of the user for whom this style sheet preference applies, enabling user-specific UI customization.
        /// </summary>
        field(1; "User ID"; Guid)
        {
            Caption = 'User ID';
            TableRelation = User."User Security ID";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        /// <summary>
        /// Type of object (Report or Page) for which the style sheet selection applies, determining the styling context.
        /// </summary>
        field(2; "Object Type"; Option)
        {
            Caption = 'Object Type';
            OptionMembers = ,"Report","Page";
            OptionCaption = ',Report,Page';
        }
        /// <summary>
        /// Unique identifier of the specific object (report or page) for which this style sheet preference is defined.
        /// </summary>
        field(3; "Object ID"; Integer)
        {
            Caption = 'Object ID';
            TableRelation = System.Reflection.Object.ID WHERE(Type = FIELD("Object Type"));
        }
        /// <summary>
        /// Identifier of the program or application context in which this style sheet preference applies, enabling program-specific styling.
        /// </summary>
        field(4; "Program ID"; Guid)
        {
            Caption = 'Program ID';
        }
        /// <summary>
        /// Unique identifier of the selected style sheet that should be used as the default for this user and object combination.
        /// </summary>
        field(5; "Style Sheet ID"; Guid)
        {
            Caption = 'Style Sheet ID';
        }
    }

    keys
    {
        key(Key1; "User ID", "Object Type", "Object ID", "Program ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

