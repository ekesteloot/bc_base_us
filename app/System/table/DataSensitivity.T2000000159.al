// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Privacy;

using System.Environment;
using System.Reflection;

/// <summary>
/// Stores data sensitivity classifications for table fields to support GDPR compliance and data privacy management.
/// Enables administrators to classify and track sensitive data across all tables and companies in the tenant.
/// </summary>
/// <remarks>
/// This table provides centralized management of data sensitivity classifications for compliance reporting,
/// data subject requests, and privacy impact assessments. Integrates with the Data Classification framework
/// and supports audit trails for sensitivity classification changes.
/// </remarks>
table 2000000159 "Data Sensitivity"
{
    Caption = 'Data Sensitivity';
    DataPerCompany = false;
    Scope = OnPrem;
    ReplicateData = false;

    fields
    {
        /// <summary>
        /// Name of the company where the data sensitivity classification applies.
        /// </summary>
        field(1; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            TableRelation = Company.Name;
        }
        /// <summary>
        /// Numeric identifier of the table containing the classified field.
        /// </summary>
        field(2; "Table No"; Integer)
        {
            Caption = 'Table No';
        }
        /// <summary>
        /// Numeric identifier of the specific field being classified for data sensitivity.
        /// </summary>
        field(3; "Field No"; Integer)
        {
            Caption = 'Field No';
        }
        /// <summary>
        /// Display caption of the table containing the classified field.
        /// </summary>
        field(4; "Table Caption"; Text[249])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST("Table"),
                                                                           "Object ID" = FIELD("Table No")));
            Caption = 'Table Caption';
            FieldClass = FlowField;
        }
        /// <summary>
        /// Display caption of the field being classified for data sensitivity.
        /// </summary>
        field(5; "Field Caption"; Text[80])
        {
            CalcFormula = Lookup(Field."Field Caption" WHERE(TableNo = FIELD("Table No"),
                                                              "No." = FIELD("Field No")));
            Caption = 'Field Caption';
            FieldClass = FlowField;
        }
        /// <summary>
        /// Data type of the field being classified (Text, Integer, Boolean, etc.).
        /// </summary>
        field(6; "Field Type"; Option)
        {
            CalcFormula = Lookup(Field.Type WHERE(TableNo = FIELD("Table No"),
                                                   "No." = FIELD("Field No")));
            Caption = 'Field Type';
            FieldClass = FlowField;
            OptionCaption = 'TableFilter,RecordID,OemText,Date,Time,DateFormula,Decimal,Media,MediaSet,Text,Code,Binary,BLOB,Boolean,Integer,OemCode,Option,BigInteger,Duration,GUID,DateTime';
            OptionMembers = TableFilter,RecordID,OemText,Date,Time,DateFormula,Decimal,Media,MediaSet,Text,"Code",Binary,BLOB,Boolean,"Integer",OemCode,Option,BigInteger,Duration,GUID,DateTime;
        }
        /// <summary>
        /// Data sensitivity classification level assigned to the field for privacy compliance.
        /// </summary>
        field(7; "Data Sensitivity"; Option)
        {
            Caption = 'Data Sensitivity';
            OptionCaption = 'Unclassified,Sensitive,Personal,Company Confidential,Normal';
            OptionMembers = Unclassified,Sensitive,Personal,"Company Confidential",Normal;
        }
        /// <summary>
        /// User security ID of the person who last modified the data sensitivity classification.
        /// </summary>
        field(8; "Last Modified By"; Guid)
        {
            Caption = 'Last Modified By';
        }
        /// <summary>
        /// Date and time when the data sensitivity classification was last modified.
        /// </summary>
        field(9; "Last Modified"; DateTime)
        {
            Caption = 'Last Modified';
        }
        /// <summary>
        /// Standard data classification defined in the field's metadata for compliance frameworks.
        /// </summary>
        field(10; "Data Classification"; Option)
        {
            CalcFormula = Lookup(Field.DataClassification WHERE(TableNo = FIELD("Table No"),
                                                                 "No." = FIELD("Field No")));
            Caption = 'Data Classification';
            FieldClass = FlowField;
            OptionCaption = 'CustomerContent,ToBeClassified,EndUserIdentifiableInformation,AccountData,EndUserPseudonymousIdentifiers,OrganizationIdentifiableInformation,SystemMetadata';
            OptionMembers = CustomerContent,ToBeClassified,EndUserIdentifiableInformation,AccountData,EndUserPseudonymousIdentifiers,OrganizationIdentifiableInformation,SystemMetadata;
        }
    }

    keys
    {
        key(Key1; "Company Name", "Table No", "Field No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

