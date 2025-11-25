// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Reflection;

/// <summary>
/// Virtual table that provides information about all control fields across different object types.
/// </summary>
/// <remarks>
/// This table exposes metadata about control fields from various AL objects including reports, XMLports,
/// and pages, providing a unified view of field controls across the system. Essential for cross-object
/// analysis, field usage tracking, and building tools that need to understand field relationships
/// across different object types. Used by development and analysis tools to provide comprehensive
/// field control discovery and metadata extraction capabilities.
/// </remarks>
table 2000000202 "All Control Fields"
{
    Caption = 'All Control Fields';
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// The type of AL object that contains this control field (Report, XMLport, or Page).
        /// </summary>
        field(1; "Object Type"; Option)
        {
            Caption = 'Object Type';
            OptionMembers = ,,,"Report",,,"XMLport",,"Page",,,,,,,,,,,;
            OptionCaption = ',,,Report,,,XMLport,,Page,,,,,,,,,,,';
        }
        /// <summary>
        /// The ID of the object that contains this control field.
        /// </summary>
        field(2; "Object ID"; Integer)
        {
            Caption = 'Object ID';
        }
        /// <summary>
        /// The unique identifier of the control within the object.
        /// </summary>
        field(3; "Control ID"; Integer)
        {
            Caption = 'Control ID';
        }
        /// <summary>
        /// The name of the control as defined in the AL code.
        /// </summary>
        field(4; "Control Name"; Text[120])
        {
            Caption = 'Control Name';
        }
        /// <summary>
        /// The data type of the control field (e.g., Text, Integer, Boolean, Date, etc.).
        /// </summary>
        field(5; "Data Type"; Option)
        {
            Caption = 'Data Type';
            OptionMembers = BigInteger,Binary,Blob,Boolean,Code,Date,DateFormula,DateTime,Decimal,Duration,GUID,Integer,Media,MediaSet,OEMCode,OemText,Option,RecordID,TableFilter,Text,Time;
            OptionOrdinalValues = 36095, 33791, 33793, 34047, 31489, 11775, 11797, 37375, 12799, 36863, 37119, 34559, 26207, 26208, 35071, 11519, 35583, 4988, 4912, 31488, 11776;
        }
        /// <summary>
        /// The length specification for text and code data types.
        /// </summary>
        field(6; "Data Type Length"; Integer)
        {
            Caption = 'Data Type Length';
        }
        /// <summary>
        /// The option string for controls bound to option fields.
        /// </summary>
        field(7; "Option String"; Text[2048])
        {
            Caption = 'Option String';
        }
        /// <summary>
        /// The option caption string for controls bound to option fields.
        /// </summary>
        field(8; "Option Caption"; Text[2048])
        {
            Caption = 'Option Caption';
        }
        /// <summary>
        /// The display caption of the control field.
        /// </summary>
        field(9; "Caption"; Text[250])
        {
            Caption = 'Caption';
        }
        /// <summary>
        /// The ID of the table that this control field is related to or bound to.
        /// </summary>
        field(10; "Related Table ID"; Integer)
        {
            Caption = 'Related Table ID';
        }
        /// <summary>
        /// The ID of the specific field in the related table that this control is bound to.
        /// </summary>
        field(11; "Related Field ID"; Integer)
        {
            Caption = 'Related Field ID';
        }
        /// <summary>
        /// The source expression that provides the data for this control field.
        /// </summary>
        field(12; "Source Expression"; Text[512])
        {
            Caption = 'Source Expression';
        }
    }
    keys
    {
        key(PK; "Object Type", "Object ID", "Control ID")
        {
        }
    }
}