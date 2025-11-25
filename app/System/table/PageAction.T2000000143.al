// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Reflection;

/// <summary>
/// Virtual table that provides metadata about actions defined on pages.
/// </summary>
/// <remarks>
/// This table exposes information about page actions including their hierarchy,
/// types, captions, and runtime behavior. Essential for page analysis tools, UI customization,
/// and dynamic action discovery. Used by development tools to understand page structure and
/// by the platform to resolve action references and determine action availability.
/// The table provides read-only access to action metadata across all pages in the system.
/// </remarks>
table 2000000143 "Page Action"
{
    Caption = 'Page Action';
    DataPerCompany = false;
    Scope = Cloud;
    InherentPermissions = rX;

    fields
    {
        /// <summary>
        /// The ID of the page that contains this action.
        /// </summary>
        field(1; "Page ID"; Integer)
        {
            Caption = 'Page ID';
        }
        /// <summary>
        /// The sequential index of this action within the page's action structure.
        /// </summary>
        field(2; "Action Index"; Integer)
        {
            Caption = 'Action Index';
        }
        /// <summary>
        /// The unique identifier of this action within the page.
        /// </summary>
        field(3; "Action ID"; Integer)
        {
            Caption = 'Action ID';
        }
        /// <summary>
        /// The indentation level of this action in the action hierarchy.
        /// </summary>
        field(4; Indentation; Integer)
        {
            Caption = 'Indentation';
        }
        /// <summary>
        /// The ID of the parent action if this action is nested within another action.
        /// </summary>
        field(5; "Parent Action ID"; Integer)
        {
            Caption = 'Parent Action ID';
        }
        /// <summary>
        /// The type category of this action (ActionContainer, Action, Separator, etc.).
        /// </summary>
        field(6; "Action Type"; Option)
        {
            Caption = 'Action Type';
            OptionMembers = ActionContainer,Action,Separator,ActionGroup,CustomAction,FileUploadAction;
        }
        /// <summary>
        /// The subtype classification of this action providing more specific categorization.
        /// </summary>
        field(7; "Action Subtype"; Option)
        {
            Caption = 'Action Subtype';
            OptionMembers = ,NewDocumentItems,ActionItems,RelatedInformation,Reports,HomeItems,ActivityButtons,Departments,,,,,SystemActions,Prompting,PromptGuide;
        }
        /// <summary>
        /// The name identifier of this action as defined in AL code.
        /// </summary>
        field(8; Name; Text[120])
        {
            Caption = 'Name';
        }
        /// <summary>
        /// The display caption of this action shown in the user interface.
        /// </summary>
        field(9; Caption; Text[80])
        {
            Caption = 'Caption';
        }
        /// <summary>
        /// The first part of the tooltip text for this action.
        /// </summary>
        field(10; ToolTip1; Text[250])
        {
            Caption = 'ToolTip1';
        }
        /// <summary>
        /// The second part of the tooltip text for this action.
        /// </summary>
        field(11; ToolTip2; Text[250])
        {
            Caption = 'ToolTip2';
        }
        /// <summary>
        /// The third part of the tooltip text for this action.
        /// </summary>
        field(12; ToolTip3; Text[250])
        {
            Caption = 'ToolTip3';
        }
        /// <summary>
        /// The fourth part of the tooltip text for this action.
        /// </summary>
        field(13; ToolTip4; Text[250])
        {
            Caption = 'ToolTip4';
        }
        /// <summary>
        /// Indicates whether this action is promoted to the ribbon or action bar.
        /// </summary>
        field(14; Promoted; Boolean)
        {
            Caption = 'Promoted';
        }
        /// <summary>
        /// The type of object that this action runs (Page, Report, Codeunit, or XMLport).
        /// </summary>
        field(15; RunObjectType; Option)
        {
            Caption = 'RunObjectType';
            OptionMembers = ,Page,Report,Codeunit,XMLport;
        }
        /// <summary>
        /// The ID of the object that this action runs when executed.
        /// </summary>
        field(16; RunObjectID; Integer)
        {
            Caption = 'RunObjectID';
        }
        /// <summary>
        /// The mode in which a page should be opened when this action runs a page.
        /// </summary>
        field(17; RunPageMode; Option)
        {
            Caption = 'RunPageMode';
            OptionMembers = ,View,Edit,Create;
        }
        /// <summary>
        /// The source table for the object that this action runs.
        /// </summary>
        field(18; RunSourceTable; Integer)
        {
            Caption = 'RunSourceTable';
        }
        /// <summary>
        /// The application areas where this action is available.
        /// </summary>
        field(19; ApplicationArea; Text[250])
        {
            Caption = 'ApplicationArea';
        }
    }
    keys
    {
        key(Key1; "Page ID", "Action Index")
        {
        }
    }
}