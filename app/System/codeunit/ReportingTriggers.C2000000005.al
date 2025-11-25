// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment;

/// <summary>
/// Provides business events for extending report processing functionality including printer management, layout handling, document generation, and custom merging operations.
/// </summary>
/// <remarks>
/// This codeunit serves as an extensibility layer for the reporting system, enabling partners and developers to customize report behavior, implement custom layouts, integrate with external document processing systems, and control printer settings. All events are business events that can be subscribed to by external extensions.
/// </remarks>
codeunit 2000000005 "Reporting Triggers"
{
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to specify a custom printer name for a specific report.
    /// </summary>
    /// <param name="ReportID">The ID of the report being processed.</param>
    /// <param name="PrinterName">The name of the printer to use for this report. Subscribers can modify this value to redirect output to a specific printer.</param>
    /// <remarks>
    /// Use this event to implement report-specific printer routing or to integrate with custom print management systems.
    /// </remarks>
    [BusinessEvent(false)]
    procedure GetPrinterName(ReportID: Integer; var PrinterName: Text[250])
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to customize the filename for report output files.
    /// </summary>
    /// <param name="ReportID">The ID of the report being processed.</param>
    /// <param name="Caption">The default caption or title for the report.</param>
    /// <param name="ObjectPayload">JSON object containing additional metadata about the report execution context.</param>
    /// <param name="FileExtension">The file extension for the output file (e.g., 'pdf', 'docx', 'xlsx').</param>
    /// <param name="ReportRecordRef">RecordRef to the record context for the report, if applicable.</param>
    /// <param name="FileName">The filename to use for the output file. Subscribers can modify this value to implement custom naming conventions.</param>
    /// <param name="Success">Indicates whether the filename was successfully determined by the subscriber.</param>
    /// <remarks>
    /// Use this event to implement custom file naming strategies based on report content, user preferences, or business rules.
    /// </remarks>
    [BusinessEvent(false)]
    procedure GetFilename(ReportID: Integer; Caption: Text[250]; ObjectPayload: JsonObject; FileExtension: Text[30]; ReportRecordRef: RecordRef; var FileName: Text; var Success: Boolean)
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to specify custom paper tray settings for report printing.
    /// </summary>
    /// <param name="ReportID">The ID of the report being processed.</param>
    /// <param name="FirstPage">The paper tray number to use for the first page of the report.</param>
    /// <param name="DefaultPage">The paper tray number to use for default pages of the report.</param>
    /// <param name="LastPage">The paper tray number to use for the last page of the report.</param>
    /// <remarks>
    /// Use this event to implement sophisticated paper tray management for reports that require different paper types for different sections (e.g., letterhead for first page, plain paper for body, pre-printed forms for last page).
    /// </remarks>
    [BusinessEvent(false)]
    procedure GetPaperTrayForReport(ReportID: Integer; var FirstPage: Integer; var DefaultPage: Integer; var LastPage: Integer)
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to specify whether a custom layout exists for a given object.
    /// </summary>
    /// <param name="ObjectType">The type of object (Report or Page).</param>
    /// <param name="ObjectID">The ID of the object.</param>
    /// <param name="LayoutType">The type of custom layout available (None, RDLC, Word, Excel, or Custom).</param>
    /// <remarks>
    /// Use this event to integrate with external layout management systems or to provide dynamic layout selection based on business rules.
    /// </remarks>
    [BusinessEvent(false)]
    procedure HasCustomLayout(ObjectType: Option "Report","Page"; ObjectID: Integer; var LayoutType: Option "None",RDLC,Word,Excel,Custom)
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to implement custom document merging and generation logic.
    /// </summary>
    /// <param name="ObjectID">The ID of the report object.</param>
    /// <param name="ReportAction">The action being performed (SaveAsPdf, SaveAsWord, SaveAsExcel, Preview, Print, SaveAsHtml).</param>
    /// <param name="ObjectPayload">JSON object containing metadata about the report execution context.</param>
    /// <param name="XmlData">Input stream containing the report's XML data.</param>
    /// <param name="LayoutData">Input stream containing the layout definition.</param>
    /// <param name="DocumentStream">Output stream where the merged document should be written.</param>
    /// <param name="Success">Indicates whether the custom document merge was successful.</param>
    /// <remarks>
    /// Use this event to implement custom report rendering engines, integrate with external document generation services, or apply custom formatting and styling to reports.
    /// </remarks>
    [BusinessEvent(false)]
    procedure CustomDocumentMergerEx(ObjectID: Integer; ReportAction: Option SaveAsPdf,SaveAsWord,SaveAsExcel,Preview,Print,SaveAsHtml; ObjectPayload: JsonObject; XmlData: InStream; LayoutData: InStream; var DocumentStream: OutStream; var Success: Boolean)
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to implement custom report scheduling functionality.
    /// </summary>
    /// <param name="ReportId">The ID of the report to schedule.</param>
    /// <param name="RequestPageXml">XML containing the report parameters and settings.</param>
    /// <param name="Scheduled">Indicates whether the report was successfully scheduled by the subscriber.</param>
    /// <remarks>
    /// Use this event to integrate with external job scheduling systems or to implement custom scheduling logic for reports.
    /// </remarks>
    [BusinessEvent(false)]
    procedure ScheduleReport(ReportId: Integer; RequestPageXml: Text; var Scheduled: Boolean)
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to substitute one report with another based on execution context.
    /// </summary>
    /// <param name="ReportId">The ID of the original report.</param>
    /// <param name="RunMode">The mode in which the report is being executed (Normal, ParametersOnly, Execute, Print, SaveAs, RunModal).</param>
    /// <param name="RequestPageXml">XML containing the report parameters and settings.</param>
    /// <param name="RecordRef">RecordRef to the record context for the report, if applicable.</param>
    /// <param name="NewReportId">The ID of the substitute report to use instead of the original.</param>
    /// <remarks>
    /// Use this event to implement report redirection based on user permissions, data context, or business rules. Useful for providing different report versions for different user roles or data scenarios.
    /// </remarks>
    [BusinessEvent(false)]
    procedure SubstituteReport(ReportId: Integer; RunMode: Option Normal,ParametersOnly,Execute,Print,SaveAs,RunModal; RequestPageXml: Text; RecordRef: RecordRef; var NewReportId: Integer)
    begin
    end;

    /// <summary>
    /// Business event that is triggered when a document is ready for printing.
    /// </summary>
    /// <param name="ObjectType">The type of object (Report or Page).</param>
    /// <param name="ObjectId">The ID of the object.</param>
    /// <param name="ObjectPayload">JSON object containing metadata about the object execution context.</param>
    /// <param name="DocumentStream">Input stream containing the generated document ready for printing.</param>
    /// <param name="Success">Indicates whether the print operation was handled successfully by the subscriber.</param>
    /// <remarks>
    /// Use this event to implement custom print handling, integrate with external print management systems, or apply print-specific processing to documents.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnDocumentPrintReady(ObjectType: Option "Report","Page"; ObjectId: Integer; ObjectPayload: JsonObject; DocumentStream: InStream; var Success: Boolean)
    begin
    end;

    /// <summary>
    /// Business event that is triggered when a document is ready for final processing.
    /// </summary>
    /// <param name="ObjectId">The ID of the object that generated the document.</param>
    /// <param name="ObjectPayload">JSON object containing metadata about the object execution context.</param>
    /// <param name="DocumentStream">Input stream containing the generated document.</param>
    /// <param name="TargetStream">Output stream where the processed document should be written.</param>
    /// <param name="Success">Indicates whether the document processing was handled successfully by the subscriber.</param>
    /// <remarks>
    /// Use this event to implement final document processing steps such as digital signing, watermarking, or format conversion.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnDocumentReady(ObjectId: Integer; ObjectPayload: JsonObject; DocumentStream: InStream; var TargetStream: OutStream; var Success: Boolean)
    begin
    end;

    /// <summary>
    /// Business event that is triggered when an intermediate document is ready for processing during multi-stage document generation.
    /// </summary>
    /// <param name="ObjectId">The ID of the object that generated the intermediate document.</param>
    /// <param name="ObjectPayload">JSON object containing metadata about the object execution context.</param>
    /// <param name="DocumentStream">Input stream containing the intermediate document.</param>
    /// <param name="TargetStream">Output stream where the processed intermediate document should be written.</param>
    /// <param name="Success">Indicates whether the intermediate document processing was handled successfully by the subscriber.</param>
    /// <remarks>
    /// Use this event to implement processing steps for intermediate documents in complex reporting workflows, such as applying transformations or validations during document generation.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnIntermediateDocumentReady(ObjectId: Integer; ObjectPayload: JsonObject; DocumentStream: InStream; var TargetStream: OutStream; var Success: Boolean)
    begin
    end;

    /// <summary>
    /// Business event that is triggered when a document is ready for download.
    /// </summary>
    /// <param name="ObjectId">The ID of the object that generated the document.</param>
    /// <param name="ObjectPayload">JSON object containing metadata about the object execution context.</param>
    /// <param name="DocumentStream">Input stream containing the document ready for download.</param>
    /// <param name="Success">Indicates whether the download was handled successfully by the subscriber.</param>
    /// <remarks>
    /// Use this event to implement custom download handling, integrate with external file storage systems, or apply security controls to document downloads.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnDocumentDownload(ObjectId: Integer; ObjectPayload: JsonObject; DocumentStream: InStream; var Success: Boolean)
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to configure available printers and their settings.
    /// </summary>
    /// <param name="Printers">Dictionary containing printer names as keys and their configuration settings as JSON objects.</param>
    /// <remarks>
    /// Use this event to register custom printers, configure printer capabilities, or integrate with external print management systems.
    /// </remarks>
    [BusinessEvent(false)]
    procedure SetupPrinters(var Printers: Dictionary of [Text[250], JsonObject])
    begin
    end;

    // Remaining events are internal events for providing backward compatibility for version 20 only.
    /// <summary>
    /// Business event for selecting a report layout by code. This event provides backward compatibility for version 20 only.
    /// </summary>
    /// <param name="ObjectId">The ID of the report object.</param>
    /// <param name="LayoutCode">The code identifying the layout to use.</param>
    /// <param name="LayoutType">The type of layout (None, RDLC, Word, Excel, Custom).</param>
    /// <param name="Success">Indicates whether the layout selection was successful.</param>
    /// <remarks>
    /// This event is maintained for backward compatibility with version 20. New implementations should use newer layout selection mechanisms.
    /// </remarks>
    [BusinessEvent(false)]
    procedure SelectReportLayoutCode(ObjectId: Integer; var LayoutCode: Text; var LayoutType: Option "None",RDLC,Word,Excel,Custom; var Success: Boolean)
    begin
    end;

    /// <summary>
    /// Business event for fetching a report layout by its code. This event provides backward compatibility for version 20 only.
    /// </summary>
    /// <param name="ObjectId">The ID of the report object.</param>
    /// <param name="LayoutCode">The code identifying the layout to fetch.</param>
    /// <param name="TargetStream">Output stream where the layout data should be written.</param>
    /// <param name="Success">Indicates whether the layout was successfully retrieved.</param>
    /// <remarks>
    /// This event is maintained for backward compatibility with version 20. New implementations should use newer layout retrieval mechanisms.
    /// </remarks>
    [BusinessEvent(false)]
    procedure FetchReportLayoutByCode(ObjectId: Integer; LayoutCode: Text; var TargetStream: OutStream; var Success: Boolean)
    begin
    end;

    /// <summary>
    /// Obsolete business event for application report merge strategy. Support for legacy Word application render has been removed.
    /// </summary>
    /// <param name="ObjectId">The ID of the report object.</param>
    /// <param name="LayoutCode">The code identifying the layout.</param>
    /// <param name="InApplication">Whether the merge should be performed in the application.</param>
    /// <remarks>
    /// This event is obsolete as support for the legacy Word application render has been removed.
    /// </remarks>
    [BusinessEvent(false)]
    [Obsolete('Support for the legacy Word application render has been removed.')]
    procedure ApplicationReportMergeStrategy(ObjectId: Integer; LayoutCode: Text; var InApplication: boolean)
    begin
    end;

    // Backward compatibility only. To be depricated when MergeDocument is removed
    /// <summary>
    /// Obsolete business event for Word document merger application mode. Support for legacy Word application render has been removed.
    /// </summary>
    /// <param name="ObjectId">The ID of the report object.</param>
    /// <param name="LayoutCode">The code identifying the layout.</param>
    /// <param name="InApplication">Whether the merge should be performed in the application.</param>
    /// <remarks>
    /// This event is obsolete and maintained for backward compatibility only. It will be deprecated when MergeDocument is removed.
    /// </remarks>
    [BusinessEvent(false)]
    [Obsolete('Support for the legacy Word application render has been removed.')]
    procedure WordDocumentMergerAppMode(ObjectId: Integer; LayoutCode: Text; var InApplication: boolean)
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to specify the selected built-in layout type for a report.
    /// </summary>
    /// <param name="ObjectID">The ID of the report object.</param>
    /// <param name="LayoutType">The type of built-in layout selected (None, RDLC, Word, Excel, Custom).</param>
    /// <remarks>
    /// Use this event to control which built-in layout type should be used for a specific report based on business rules or user preferences.
    /// </remarks>
    [BusinessEvent(false)]
    procedure SelectedBuiltinLayoutType(ObjectID: Integer; var LayoutType: Option "None",RDLC,Word,Excel,Custom)
    begin
    end;

    // Allows layout selection from the first party extension "Report Layouts"
    /// <summary>
    /// Business event that allows layout selection through a user interface, primarily used by the "Report Layouts" extension.
    /// </summary>
    /// <param name="ObjectId">The ID of the report object.</param>
    /// <param name="LayoutName">The name of the selected layout.</param>
    /// <param name="LayoutAppID">The GUID of the app that provides the layout.</param>
    /// <param name="Success">Indicates whether the layout selection was successful.</param>
    /// <remarks>
    /// This event enables UI-based layout selection and is primarily used by the first-party "Report Layouts" extension to provide a user-friendly layout selection experience.
    /// </remarks>
    [BusinessEvent(false)]
    procedure SelectReportLayoutUI(ObjectId: Integer; var LayoutName: Text; var LayoutAppID: Guid; var Success: Boolean)
    begin
    end;
}