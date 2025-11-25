// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Security.AccessControl;

/// <summary>
/// Maps user identities and group memberships to entitlement sets for license-based access control and permission assignment.
/// </summary>
/// <remarks>
/// This table manages the relationship between various identity types (Azure AD plans, roles, users, applications) and their corresponding entitlement sets. Supports complex licensing scenarios including evaluation licenses and delegated permissions. Used by the security system for runtime permission resolution and license enforcement.
/// </remarks>
table 2000000195 "Membership Entitlement"
{
    Caption = 'Membership Entitlement';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Type of identity or membership that grants access to the associated entitlement set.
        /// </summary>
        field(1; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Azure AD Plan,Azure AD Role,User Security ID,Application ID,NAV Application ID,Azure AD Delegated Role,Azure AD Group,Azure AD Device Plan,Azure AD Application Scope';
            OptionMembers = "Azure AD Plan","Azure AD Role","User Security ID","Application ID","NAV Application ID","Azure AD Delegated Role","Azure AD Group","Azure AD Device Plan","Azure AD Application Scope";
        }
        /// <summary>
        /// Unique identifier for the specific identity or membership of the specified type.
        /// </summary>
        field(2; ID; Text[250])
        {
            Caption = 'ID';
        }
        /// <summary>
        /// Display name for the identity or membership used for identification and administrative purposes.
        /// </summary>
        field(3; Name; Text[250])
        {
            Caption = 'Name';
        }
        /// <summary>
        /// Identifier of the entitlement set that this membership grants access to.
        /// </summary>
        field(4; "Entitlement Set ID"; Code[20])
        {
            Caption = 'Entitlement Set ID';
            TableRelation = "Entitlement Set".ID WHERE(ID = FIELD("Entitlement Set ID"));
        }
        /// <summary>
        /// Display name of the entitlement set for user identification and administrative reporting.
        /// </summary>
        field(5; "Entitlement Set Name"; Text[250])
        {
            CalcFormula = Lookup("Entitlement Set".Name WHERE(ID = FIELD("Entitlement Set ID")));
            Caption = 'Entitlement Set Name';
            FieldClass = FlowField;
        }
        /// <summary>
        /// Indicates whether this membership entitlement is part of an evaluation or trial license with limited duration.
        /// </summary>
        field(6; "Is Evaluation"; Boolean)
        {
            Caption = 'Is Evaluation';
        }
    }

    keys
    {
        key(Key1; Type, ID, "Entitlement Set ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

