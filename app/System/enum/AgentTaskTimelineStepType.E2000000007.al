// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Agents;

enum 2000000007 "Agent Task Timeline Step Type"
{
    Extensible = false;
    Caption = 'Agent Task Timeline Step Type';
    Scope = OnPrem;

    /// <summary>
    /// The default type.
    /// </summary>
    value(0; Default)
    {
        Caption = 'Default';
    }

    /// <summary>
    /// An input message.
    /// </summary>
    value(1; InputMessage)
    {
        Caption = 'Input Message';
    }

    /// <summary>
    /// An output message.
    /// </summary>
    value(2; OutputMessage)
    {
        Caption = 'Output Message';
    }

    /// <summary>
    /// A user intervention request.
    /// </summary>
    value(3; UserInterventionRequest)
    {
        Caption = 'User Intervention Request';
    }
}