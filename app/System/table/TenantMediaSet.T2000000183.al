// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment;

/// <summary>
/// Manages collections of media items for tenant-specific media storage and organization.
/// </summary>
/// <remarks>
/// This table provides a grouping mechanism for media files within the tenant, allowing multiple media items
/// to be organized into logical sets. Each media set has a unique identifier and can contain multiple media
/// references with indexed ordering. Supports company-specific media organization and provides efficient
/// lookup capabilities through media indexing. Used by the media management framework to organize and
/// reference collections of media files such as image galleries or document sets.
/// </remarks>
table 2000000183 "Tenant Media Set"
{
    Caption = 'Tenant Media Set';
    DataPerCompany = false;
    Scope = Cloud;
    InherentPermissions = rX;

    fields
    {
        /// <summary>
        /// Unique identifier for the media set.
        /// </summary>
        field(1; ID; Guid)
        {
            Caption = 'ID';
        }
        /// <summary>
        /// Reference to a media item within this media set.
        /// </summary>
        field(2; "Media ID"; Media)
        {
            Caption = 'Media ID';
        }
        /// <summary>
        /// Name of the company this media set belongs to, if company-specific.
        /// </summary>
        field(3; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            TableRelation = System.Environment.Company.Name;
        }
        /// <summary>
        /// Index number for ordering media items within the set.
        /// </summary>
        field(4; "Media Index"; BigInteger)
        {
            Caption = 'Media Index';
        }
    }

    keys
    {
        key(Key1; ID, "Media ID")
        {
            Clustered = true;
        }
        key(Key2; "Media Index")
        {
        }
        key(Key3; "Company Name")
        {
        }
    }

    fieldgroups
    {
    }
}

