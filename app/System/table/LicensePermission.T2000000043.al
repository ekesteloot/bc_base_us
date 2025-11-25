// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Security.AccessControl;

/// <summary>
/// Virtual table that provides information about permissions granted by the current license.
/// </summary>
/// <remarks>
/// This table exposes the permissions that are available based on the license configuration,
/// showing which objects can be accessed and what operations are permitted. Essential for
/// understanding license limitations, compliance checking, and security boundary enforcement.
/// Used by the platform to validate that user operations are within licensed capabilities
/// and by administrators to understand the scope of permitted functionality.
/// </remarks>
table 2000000043 "License Permission"
{
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// The type of AL object that this license permission applies to.
        /// </summary>
        field(1; "Object Type"; Option)
        {
            OptionMembers = "TableData","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber","LimitedUsageTableData",,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension","PermissionSet","PermissionSetExtension","ReportExtension";
            OptionCaption = 'TableData,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,System,FieldNumber,LimitedUsageTableData,,PageExtension,TableExtension,Enum,EnumExtension,Profile,ProfileExtension,PermissionSet,PermissionSetExtension,ReportExtension';
        }
        /// <summary>
        /// The number or ID of the specific object that this license permission applies to.
        /// </summary>
        field(2; "Object Number"; Integer)
        {
        }
        /// <summary>
        /// The read permission level granted by the license for this object.
        /// </summary>
        field(10; "Read Permission"; Option)
        {
            OptionMembers = " ",Yes,Indirect;
        }
        /// <summary>
        /// The insert permission level granted by the license for this object.
        /// </summary>
        field(11; "Insert Permission"; Option)
        {
            OptionMembers = " ",Yes,Indirect;
        }
        /// <summary>
        /// The modify permission level granted by the license for this object.
        /// </summary>
        field(12; "Modify Permission"; Option)
        {
            OptionMembers = " ",Yes,Indirect;
        }
        /// <summary>
        /// The delete permission level granted by the license for this object.
        /// </summary>
        field(13; "Delete Permission"; Option)
        {
            OptionMembers = " ",Yes,Indirect;
        }
        /// <summary>
        /// The execute permission level granted by the license for this object.
        /// </summary>
        field(14; "Execute Permission"; Option)
        {
            OptionMembers = " ",Yes,Indirect;
        }
        /// <summary>
        /// The limited usage permission setting for this object in the license.
        /// </summary>
        field(15; "Limited Usage Permission"; Option)
        {
            OptionMembers = " ",Included,Excluded,Optional;
        }
    }

    keys
    {
        key(PK; "Object Type", "Object Number")
        {
            Clustered = true;
        }
    }
}