// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Security.AccessControl;

/// <summary>
/// Virtual table that provides information about permission ranges defined for object access control.
/// This table enables understanding of permissions granted for ranges of objects in the security system.
/// </summary>
/// <remarks>
/// The Permission Range table is fundamental to Business Central's security model, providing detailed
/// information about permissions granted for ranges of objects rather than individual objects.
/// It defines access rights (Read, Insert, Modify, Delete, Execute) for ranges of tables, pages,
/// reports, codeunits, and other AL objects. This table is essential for security administration,
/// permission analysis, and ensuring proper access control across the system. The range-based
/// approach allows for permission management when dealing with large numbers of related
/// objects. This table is only available in on-premises deployments where direct permission
/// inspection is required for security auditing and compliance purposes.
/// </remarks>
table 2000000044 "Permission Range"
{
    DataPerCompany = false;
    Scope = OnPrem;
    fields
    {
        /// <summary>
        /// The type of AL object covered by this permission range.
        /// </summary>
        field(1; "Object Type"; Option)
        {
            OptionCaption = 'TableData,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,System,FieldNumber,LimitedUsageTableData,,PageExtension,TableExtension,Enum,EnumExtension,Profile,ProfileExtension,PermissionSet,PermissionSetExtension,ReportExtension';
            OptionMembers = "TableData","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber","LimitedUsageTableData",,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension","PermissionSet","PermissionSetExtension","ReportExtension";
        }
        /// <summary>
        /// The index number of this permission range entry within the object type.
        /// </summary>
        field(2; Index; Integer)
        {
        }
        /// <summary>
        /// The starting object ID number in the permission range.
        /// </summary>
        field(3; From; Integer)
        {
        }
        /// <summary>
        /// The ending object ID number in the permission range.
        /// </summary>
        field(4; To; Integer)
        {
        }
        /// <summary>
        /// The read permission level granted for objects in this range.
        /// </summary>
        field(10; "Read Permission"; Option)
        {
            OptionMembers = " ",Yes,Indirect;
            OptionCaption = ' ,Yes,Indirect';
        }
        /// <summary>
        /// The insert permission level granted for objects in this range.
        /// </summary>
        field(11; "Insert Permission"; Option)
        {
            OptionMembers = " ",Yes,Indirect;
            OptionCaption = ' ,Yes,Indirect';
        }
        /// <summary>
        /// The modify permission level granted for objects in this range.
        /// </summary>
        field(12; "Modify Permission"; Option)
        {
            OptionMembers = " ",Yes,Indirect;
            OptionCaption = ' ,Yes,Indirect';
        }
        /// <summary>
        /// The delete permission level granted for objects in this range.
        /// </summary>
        field(13; "Delete Permission"; Option)
        {
            OptionMembers = " ",Yes,Indirect;
            OptionCaption = ' ,Yes,Indirect';
        }
        /// <summary>
        /// The execute permission level granted for objects in this range.
        /// </summary>
        field(14; "Execute Permission"; Option)
        {
            OptionMembers = " ",Yes,Indirect;
            OptionCaption = ' ,Yes,Indirect';
        }
        /// <summary>
        /// The limited usage permission setting for objects in this range when restricted access is required.
        /// </summary>
        field(15; "Limited Usage Permission"; Option)
        {
            OptionMembers = " ",Included,Excluded,Optional;
            OptionCaption = ' ,Included,Excluded,Optional';
        }
    }

    keys
    {
        key(pk; "Object Type", Index)
        {

        }
    }
}