// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Reflection;

/// <summary>
/// Virtual table that provides detailed information about control fields on pages.
/// </summary>
/// <remarks>
/// This table exposes metadata about individual field controls on pages, including their
/// properties, expressions, and runtime behavior settings. Essential for page analysis,
/// UI customization tools, and dynamic form generation. Used by development environments
/// to understand page structure and by the platform to resolve field control properties
/// and expressions at runtime. The table provides field control metadata
/// for all pages in the system.
/// </remarks>
table 2000000192 "Page Control Field"
{
    Caption = 'Page Control Field';
    DataPerCompany = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// The ID of the page that contains this control field.
        /// </summary>
        field(1; PageNo; Integer)
        {
            Caption = 'PageNo';
        }
        /// <summary>
        /// The unique identifier of the control within the page.
        /// </summary>
        field(2; ControlId; Integer)
        {
            Caption = 'ControlId';
        }
        /// <summary>
        /// The name of the control as defined in the page AL code.
        /// </summary>
        field(3; ControlName; Text[120])
        {
            Caption = 'ControlName';
        }
        /// <summary>
        /// The number of the table that this control field is bound to.
        /// </summary>
        field(4; TableNo; Integer)
        {
            Caption = 'TableNo';
        }
        /// <summary>
        /// The field number in the table that this control is bound to.
        /// </summary>
        field(5; FieldNo; Integer)
        {
            Caption = 'FieldNo';
        }
        /// <summary>
        /// The expression that determines whether this control is enabled.
        /// </summary>
        field(6; Enabled; Text[512])
        {
            Caption = 'Enabled';
        }
        /// <summary>
        /// The expression that determines whether this control is editable.
        /// </summary>
        field(7; Editable; Text[512])
        {
            Caption = 'Editable';
        }
        /// <summary>
        /// The expression that determines whether this control is visible.
        /// </summary>
        field(8; Visible; Text[512])
        {
            Caption = 'Visible';
        }
        /// <summary>
        /// The source expression that provides the data for this control.
        /// </summary>
        field(9; SourceExpression; Text[512])
        {
            Caption = 'Source Expression';
        }
        /// <summary>
        /// The option string for controls bound to option fields.
        /// </summary>
        field(10; OptionString; Text[2048])
        {
            Caption = 'Option String';
        }
        /// <summary>
        /// The sequence number indicating the order of this control on the page.
        /// </summary>
        field(11; Sequence; Integer)
        {
            Caption = 'Sequence';
        }
    }
    keys
    {
        key(Key1; PageNo, ControlId)
        {
        }
    }
}