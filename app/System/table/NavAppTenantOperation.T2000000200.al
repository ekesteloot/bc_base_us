// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Apps;

/// <summary>
/// Stores tenant-level app operation records, tracking deployment and management activities for Business Central applications.
/// </summary>
/// <remarks>
/// This table manages the execution status and details of app operations within a specific tenant environment.
/// Each record represents a specific operation (deployment, package installation) with status tracking and metadata.
/// Essential for app lifecycle management, deployment monitoring, and troubleshooting app installation issues.
/// </remarks>
table 2000000200 "NAV App Tenant Operation"
{
    Caption = 'NAV App Tenant Operation';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// The unique identifier for this app operation.
        /// </summary>
        field(1; "Operation ID"; Guid)
        {
            Caption = 'Operation ID';
        }
        /// <summary>
        /// The date and time when this app operation was initiated.
        /// </summary>
        field(2; "Started On"; DateTime)
        {
            Caption = 'Started On';
        }
        /// <summary>
        /// The type of operation being performed on the app.
        /// </summary>
        field(3; "Operation Type"; Option)
        {
            Caption = 'Operation Type';
            OptionCaption = 'DeployTarget,DeployPackage';
            OptionMembers = DeployTarget,DeployPackage;
        }
        /// <summary>
        /// The current status of the app operation execution.
        /// </summary>
        field(4; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Unknown,InProgress,Failed,Completed,NotFound';
            OptionMembers = Unknown,InProgress,Failed,Completed,NotFound;
        }
        /// <summary>
        /// Additional details about the operation execution, including error messages or progress information.
        /// </summary>
        field(5; Details; BLOB)
        {
            Caption = 'Details';
        }
        /// <summary>
        /// The version number of the metadata structure used for this operation.
        /// </summary>
        field(6; "Metadata Version"; Integer)
        {
            Caption = 'Metadata Version';
        }
        /// <summary>
        /// The metadata information associated with this app operation.
        /// </summary>
        field(7; Metadata; BLOB)
        {
            Caption = 'Metadata';
        }
        /// <summary>
        /// The key identifier for the metadata associated with this operation.
        /// </summary>
        field(8; "Metadata Key"; Text[250])
        {
            Caption = 'Metadata Key';
        }
        /// <summary>
        /// A description of the app operation, providing more context about its purpose or details.
        /// </summary>
        field(9; Description; Text[250])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Operation ID")
        {
            Clustered = true;
        }
        key(Key2; "Operation Type", "Metadata Key")
        {
        }
    }

    fieldgroups
    {
    }
}

