// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment.Configuration;

/// <summary>
/// Stores contextual information collected during tenant signup process for Business Central cloud environments.
/// </summary>
/// <remarks>
/// This table manages key-value pairs of information gathered during the tenant registration and setup process.
/// Each record represents a specific piece of context data that influences tenant configuration and initialization.
/// Essential for cloud onboarding processes, enabling personalized setup and configuration based on signup context.
/// </remarks>
table 2000000255 "Signup Context"
{
    Caption = 'Signup Context';
    DataPerCompany = false;
    ReplicateData = false;
    Scope = Cloud;

    fields
    {
        /// <summary>
        /// The key name identifying the type of signup context information stored.
        /// </summary>
        field(1; KeyName; Text[128])
        {
            Caption = 'Key';
        }
        /// <summary>
        /// The value associated with the signup context key.
        /// </summary>
        field(2; Value; Text[2000])
        {
            Caption = 'Value';
        }
    }

    keys
    {
        key(Key1; KeyName)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}