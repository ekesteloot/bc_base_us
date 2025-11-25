// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Security.AccessControl;

/// <summary>
/// Stores device registration information for device-based licensing and access control.
/// Manages device identities, capabilities, and activation status for Business Central access.
/// </summary>
/// <remarks>
/// This table supports device-only user licensing scenarios where specific devices are registered
/// for Business Central access. Integrates with licensing systems, device authentication, and
/// access control mechanisms for device-based deployment scenarios.
/// </remarks>
table 2000000130 Device
{
    Caption = 'Device';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;
    InherentPermissions = rX;

    fields
    {
        /// <summary>
        /// Media Access Control address uniquely identifying the network device.
        /// </summary>
        field(1; "MAC Address"; Code[20])
        {
            Caption = 'MAC Address';
        }
        /// <summary>
        /// Descriptive name assigned to the device for identification purposes.
        /// </summary>
        field(2; Name; Text[80])
        {
            Caption = 'Name';
        }
        /// <summary>
        /// License type classification determining the device's functional capabilities and restrictions.
        /// </summary>
        field(3; "Device Type"; Option)
        {
            Caption = 'Device Type';
            OptionCaption = 'Full,Limited,ISV,ISV Functional';
            OptionMembers = Full,Limited,ISV,"ISV Functional";
        }
        /// <summary>
        /// Indicates whether the device is currently enabled for Business Central access.
        /// </summary>
        field(4; Enabled; Boolean)
        {
            Caption = 'Enabled';
        }
    }

    keys
    {
        key(Key1; "MAC Address")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

