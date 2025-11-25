// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment.Consumption;

using System.Agents.Internal;
using System.Security.AccessControl;

/// <summary>
/// Table to log user consumption events for auditing and tracking purposes.
/// </summary>
table 2000000295 "User AI Consumption Data"
{
    Caption = 'User AI Consumption Data';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = OnPrem;

    fields
    {
        /// <summary>
        /// Auto-incrementing unique identifier.
        /// </summary>
        field(1; Id; BigInteger)
        {
            AutoIncrement = true;
            Caption = 'Id';
            ToolTip = 'Specifies the unique identifier for this consumption entry.';
        }
        /// <summary>
        /// Date and time when the consumption event occurred in UTC.
        /// </summary>
        field(2; "Consumption DateTime"; DateTime)
        {
            Caption = 'Consumption DateTime';
            NotBlank = true;
            ToolTip = 'Specifies when the credits were consumed (UTC).';
        }
        /// <summary>
        /// The user who consumed the credits.
        /// </summary>
        field(3; "User Id"; Guid)
        {
            DataClassification = EndUserPseudonymousIdentifiers;
            Caption = 'User Id';
            TableRelation = User."User Security ID";
            NotBlank = true;
            ToolTip = 'Specifies the user who consumed the credits.';
        }
        /// <summary>
        /// The agent task Id related to the consumption, if any.
        /// </summary>
        field(4; "Agent Task Id"; BigInteger)
        {
            Caption = 'Agent Task Id';
            TableRelation = "Agent Task Data".Id;
            ToolTip = 'Specifies the agent task related to the consumption, if applicable.';
        }
        /// <summary>
        /// The name of the app using the consumption.
        ///
        /// Note that this is the name of the app when the consumption occurred. If the app is renamed later, this field will not be updated.
        /// </summary>
        field(5; "App Name"; Text[256])
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'App Name';
            NotBlank = true;
            ToolTip = 'Specifies the name of the app that consumed the credits.';
        }
        /// <summary>
        /// The publisher of the app using the consumption.
        ///
        /// Note that this is the publisher of the app when the consumption occurred. If the publisher is renamed later, this field will not be updated.
        /// </summary>
        field(6; "App Publisher"; Text[256])
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'App Publisher';
            NotBlank = true;
            ToolTip = 'Specifies the publisher of the app that consumed the credits.';
        }
        /// <summary>
        /// The version of the app using the consumption.
        /// </summary>
        field(7; "App Version"; Text[50])
        {
            Caption = 'App Version';
            NotBlank = true;
            ToolTip = 'Specifies the version of the app that consumed the credits.';
        }
        /// <summary>
        /// The id of the app using the consumption.
        /// </summary>
        field(8; "App Id"; Guid)
        {
            Caption = 'App Id';
            NotBlank = true;
            ToolTip = 'Specifies the ID of the app that consumed the credits.';
        }
        /// <summary>
        /// Name of the feature consuming the credits, e.g. "Sales Order Agent".
        /// </summary>
        field(9; "Feature Name"; Text[256])
        {
            Caption = 'Feature Name';
            NotBlank = true;
            ToolTip = 'Specifies the feature name that consumed the credits, for example, "Sales Order Agent".';
        }
        /// <summary>
        /// A representation of what the charge represents, e.g. "Created Sales Order".
        /// </summary>
        field(10; "Actions"; Text[1024])
        {
            Caption = 'Actions';
            ToolTip = 'Specifies what the charge represents, for example, "Created Sales Order".';
        }
        /// <summary>
        /// The Copilot Studio feature name for the charge. E.g. "GenAI Answer" or "Autonomous Action".
        /// </summary>
        field(11; "Copilot Studio Feature"; Text[1024])
        {
            Caption = 'Copilot Studio Feature';
            NotBlank = true;
            ToolTip = 'Specifies the Copilot Studio feature for the charge, for example, "GenAI Answer" or "Autonomous Action".';
        }
        /// <summary>
        /// The Copilot credit consumption.
        /// </summary>
        field(12; "Copilot Credits"; Decimal)
        {
            Caption = 'Copilot Credits';
            AutoFormatType = 1;
            DecimalPlaces = 2:2;
            NotBlank = true;
            ToolTip = 'Specifies the amount of Copilot credits consumed.';
        }
        /// <summary>
        /// The trace Id.
        /// </summary>
        field(13; "Trace Id"; Text[128])
        {
            Caption = 'Trace Id';
            NotBlank = true;
            ToolTip = 'Specifies the trace ID for this consumption event.';
        }
        /// <summary>
        /// Name of the company context in which the consumption occurred.
        /// </summary>
        field(14; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the company in which the consumption occurred.';
        }
        /// <summary>
        /// A description of what the consumption event represents.
        /// </summary>
        field(15; Description; Blob)
        {
            Caption = 'Description';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies a description of the consumption event.';
        }
        /// <summary>
        /// Unique Id of the consumption event, used for idempotency. Formated generated and specified by invoker/app.
        /// </summary>
        field(16; "Unique Id"; Text[1024])
        {
            DataClassification = OrganizationIdentifiableInformation;
            Caption = 'Unique Id';
            NotBlank = true;
            ToolTip = 'Specifies the unique ID of the consumption event, used to prevent duplicate entries.';
        }
        /// <summary>
        /// A flag indicating whether or not the consumption entry has been processed for billing. A processed entry can be showed in the UI.
        /// </summary>
        field(17; "Processed For Billing"; Boolean)
        {
            Caption = 'Processed For Billing';
            NotBlank = true;
            ToolTip = 'Specifies whether the consumption entry has been reported for billing. Only processed entries can be shown in the UI.';
        }
    }

    keys
    {
        key("Primary Key"; Id)
        {
            Clustered = true;
        }
        key("Consumption DateTime Key"; "Consumption DateTime")
        {
        }
        key("User Id Key"; "User Id")
        {
        }
        key("Agent Task Id Key"; "Agent Task Id")
        {
        }
        key("App Name Key"; "App Name")
        {
        }
        key("App Publisher Key"; "App Publisher")
        {
        }
        key("Feature Name Key"; "Feature Name")
        {
        }
        key("Copilot Studio Feature Key"; "Copilot Studio Feature")
        {
        }
        key("Trace Id Key"; "Trace Id")
        {
        }
        key("Company Name Key"; "Company Name")
        {
        }
        key("Unique Id Key"; "Unique Id")
        {
            Unique = true;
        }
        key("Processed For Billing Key"; "Processed For Billing")
        {
        }
    }

    fieldgroups
    {
    }
}