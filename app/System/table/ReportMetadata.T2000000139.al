// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Reflection;

/// <summary>
/// Virtual table that provides metadata information about all reports in the system.
/// This table enables introspection of report properties, layout configurations, and execution characteristics.
/// </summary>
/// <remarks>
/// The Report Metadata table is essential for understanding report definitions and their capabilities.
/// It includes detailed information about report layouts, printing options, data sources, and various
/// behavioral properties that control report execution and output. This table is crucial for report
/// management tools, layout selection, scheduling configuration, and administrative utilities that need
/// to understand report structures and constraints. The information covers all report types including
/// RDLC, Word, Excel, and custom layouts, providing visibility into the reporting
/// infrastructure across all applications.
/// </remarks>
table 2000000139 "Report Metadata"
{
    DataPerCompany = False;
    Scope = Cloud;
    InherentPermissions = rX;

    fields
    {
        /// <summary>
        /// The unique identifier number of the report.
        /// </summary>
        field(1; ID; Integer)
        {
        }
        /// <summary>
        /// The name of the report as defined in the AL source code.
        /// </summary>
        field(2; Name; Text[30])
        {
        }
        /// <summary>
        /// The caption text displayed for this report in the user interface.
        /// </summary>
        field(3; Caption; Text[80])
        {
        }
        /// <summary>
        /// Indicates whether the report displays a request page for parameter input before execution.
        /// </summary>
        field(4; UseRequestPage; Boolean)
        {
        }
        /// <summary>
        /// Indicates whether the report uses the system printer for output operations.
        /// </summary>
        field(5; UseSystemPrinter; Boolean)
        {
        }
        /// <summary>
        /// Indicates whether the report can access and display external images from URLs or file paths.
        /// </summary>
        field(6; EnableExternalImages; Boolean)
        {
        }
        /// <summary>
        /// Indicates whether hyperlinks are enabled and functional within the report output.
        /// </summary>
        field(7; EnableHyperLinks; Boolean)
        {
        }
        /// <summary>
        /// Indicates whether the report can use external assemblies for extended functionality.
        /// </summary>
        field(8; EnableExternalAssemblies; Boolean)
        {
        }
        /// <summary>
        /// Indicates whether the report performs processing only without generating visual output.
        /// </summary>
        field(9; ProcessingOnly; Boolean)
        {
        }
        /// <summary>
        /// Indicates whether print status information is displayed during report execution.
        /// </summary>
        field(10; ShowPrintStatus; Boolean)
        {
        }
        /// <summary>
        /// The transaction type used for database operations during report execution.
        /// </summary>
        field(11; "TransactionType"; Option)
        {
            OptionMembers = UpdateNoLocks,Update,Snapshot,Browse,Report;
        }
        /// <summary>
        /// The paper source configuration for the first page of the report.
        /// </summary>
        field(12; PaperSourceFirstPage; Integer)
        {
        }
        /// <summary>
        /// The paper source configuration for default pages of the report.
        /// </summary>
        field(13; PaperSourceDefaultPage; Integer)
        {
        }
        /// <summary>
        /// The paper source configuration for the last page of the report.
        /// </summary>
        field(14; PaperSourceLastPage; Integer)
        {
        }
        /// <summary>
        /// The preview mode used when displaying the report before printing.
        /// </summary>
        field(15; PreviewMode; Option)
        {
            OptionMembers = Normal,PrintLayout;
        }
        /// <summary>
        /// The default layout type used for rendering the report output.
        /// </summary>
        field(16; "DefaultLayout"; Option)
        {
            OptionMembers = RDLC,Word,Excel,Custom;
        }
        /// <summary>
        /// The data item configuration for Word merge operations when using Word layouts.
        /// </summary>
        field(17; WordMergeDataItem; Text[250])
        {
        }
        /// <summary>
        /// The table ID of the first data item in the report's data model.
        /// </summary>
        field(18; FirstDataItemTableID; Integer)
        {
        }
        /// <summary>
        /// The maximum number of rows that can be processed in a single report execution.
        /// </summary>
        field(19; MaxRows; Integer)
        {
        }
        /// <summary>
        /// The maximum number of documents that can be generated in a single report execution.
        /// </summary>
        field(20; MaxDocuments; Integer)
        {
        }
        /// <summary>
        /// The maximum execution time allowed for the report before it times out.
        /// </summary>
        field(21; Timeout; Duration)
        {
        }
        /// <summary>
        /// Indicates whether the report can be scheduled for automated execution.
        /// </summary>
        field(22; AllowScheduling; Boolean)
        {
        }
        /// <summary>
        /// The name of the default layout used when multiple layouts are available.
        /// </summary>
        field(23; DefaultLayoutName; Text[100])
        {
        }
        /// <summary>
        /// The regional format settings used for date, number, and currency formatting in the report.
        /// </summary>
        field(24; FormatRegion; Text[80])
        {
        }
        /// <summary>
        /// Indicates whether Excel layouts support multiple data sheets for complex data presentation.
        /// </summary>
        field(25; ExcelLayoutMultipleDataSheets; Boolean)
        {
        }
        /// <summary>
        /// The application identifier that contains this report.
        /// </summary>
        field(26; "App ID"; Guid)
        {
        }
        /// <summary>
        /// The inherent permissions defined for this report (Read, Insert, Modify, Delete).
        /// </summary>
        field(27; InherentPermissions; Text[5])
        {
        }
        /// <summary>
        /// The inherent entitlements required to access this report.
        /// </summary>
        field(28; InherentEntitlements; Text[5])
        {
        }
        /// <summary>
        /// The AL namespace of the object.
        /// </summary>
        field(29; "AL Namespace"; text[500])
        {
        }
    }

    fieldgroups
    {
        fieldgroup("DropDown"; ID, Caption)
        {
        }
    }
}