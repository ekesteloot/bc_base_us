// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment;

using System.Reflection;

/// <summary>
/// Provides business events for extending system action functionality including role center management, Excel integration, extension installation, notification handling, and application navigation.
/// </summary>
/// <remarks>
/// This codeunit serves as an extensibility layer for core system actions and UI operations, enabling partners and developers to customize user experience, integrate with external systems, implement custom navigation flows, and extend platform capabilities. All events are business events that can be subscribed to by external extensions.
/// </remarks>
codeunit 2000000006 "System Action Triggers"
{
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to specify the default role center ID for users.
    /// </summary>
    /// <param name="ID">The ID of the default role center. Subscribers can modify this value to set a custom default role center.</param>
    /// <remarks>
    /// Use this event to implement dynamic role center assignment based on user roles, permissions, or business rules.
    /// </remarks>
    [BusinessEvent(false)]
    procedure GetDefaultRoleCenterID(var ID: Integer)
    begin
    end;

    /// <summary>
    /// Internal event for getting the role center banner part ID.
    /// </summary>
    /// <param name="PartID">The ID of the role center banner part.</param>
    /// <remarks>
    /// This is an internal event used by the system to manage role center banner components.
    /// </remarks>
    [InternalEvent(false)]
    procedure GetRoleCenterBannerPartID(var PartID: Integer)
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to customize chart selection and configuration.
    /// </summary>
    /// <param name="TempChart">Temporary Chart record containing chart configuration that can be modified by subscribers.</param>
    /// <param name="LookupOK">Indicates whether the chart customization was successful and should be applied.</param>
    /// <remarks>
    /// Use this event to implement custom chart selection dialogs, apply default chart configurations, or integrate with external charting libraries.
    /// </remarks>
    [BusinessEvent(false)]
    procedure CustomizeChart(var TempChart: Record Chart temporary; var LookupOK: Boolean)
    begin
    end;

    /// <summary>
    /// Business event that is triggered when the system settings should be opened.
    /// </summary>
    /// <remarks>
    /// Use this event to implement custom settings pages, redirect to external configuration systems, or apply additional setup steps when users access system settings.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OpenSettings()
    begin
    end;

    /// <summary>
    /// Business event that is triggered when contacting Microsoft Sales should be initiated.
    /// </summary>
    /// <remarks>
    /// Use this event to implement custom contact flows, integrate with CRM systems, or provide alternative sales contact methods.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OpenContactMSSales()
    begin
    end;

    /// <summary>
    /// Obsolete business event for opening the debugger. Support for the classic debugger engine has been removed.
    /// </summary>
    /// <remarks>
    /// This event is obsolete as support for the classic debugger engine has been removed from the platform.
    /// </remarks>
    [BusinessEvent(false)]
    [Obsolete('Support for the classic debugger engine has been removed.')]
    procedure OpenDebugger()
    begin
    end;

    /// <summary>
    /// Business event that is triggered when editing data in Excel is initiated.
    /// </summary>
    /// <param name="ServiceName">The name of the OData service to use for Excel integration.</param>
    /// <param name="ODataFilter">The OData filter expression to apply to the data being edited in Excel.</param>
    /// <remarks>
    /// Use this event to customize Excel integration behavior, apply additional filters, or integrate with external Excel add-ins.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnEditInExcel(ServiceName: Text[240]; ODataFilter: Text)
    begin
    end;

    /// <summary>
    /// Business event that is triggered when opening an Excel file from a specific location.
    /// </summary>
    /// <param name="Location">The location or path of the Excel file to open.</param>
    /// <remarks>
    /// Use this event to implement custom file opening logic, apply security validation, or integrate with document management systems.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnOpenInExcel(Location: Text)
    begin
    end;

    /// <summary>
    /// Business event that is triggered when editing in Excel with a search string parameter.
    /// </summary>
    /// <param name="ServiceName">The name of the OData service to use for Excel integration.</param>
    /// <param name="ODataFilter">The OData filter expression to apply to the data.</param>
    /// <param name="SearchString">The search string to apply for filtering the data in Excel.</param>
    /// <remarks>
    /// Use this event to enhance Excel integration with search capabilities, implement custom search logic, or integrate with external search services.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnEditInExcelWithSearchString(ServiceName: Text[240]; ODataFilter: Text; SearchString: Text)
    begin
    end;

    /// <summary>
    /// Business event that is triggered when editing in Excel with structured filter and payload information.
    /// </summary>
    /// <param name="ServiceName">The name of the OData service to use for Excel integration.</param>
    /// <param name="SearchString">The search string to apply for filtering the data.</param>
    /// <param name="Filter">JSON object containing structured filter criteria.</param>
    /// <param name="Payload">JSON object containing additional payload information for the Excel integration.</param>
    /// <remarks>
    /// Use this event to implement advanced Excel integration scenarios with complex filtering and metadata, enabling sophisticated data analysis workflows.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnEditInExcelWithStructuredFilter(ServiceName: Text[240]; SearchString: Text; Filter: JsonObject; Payload: JsonObject)
    begin
    end;

    /// <summary>
    /// Business event that is triggered when extension installation should be invoked.
    /// </summary>
    /// <param name="AppId">The ID of the app to install.</param>
    /// <param name="ResponseUrl">The URL to respond to after installation completion.</param>
    /// <remarks>
    /// Use this event to implement custom extension installation flows, apply validation rules, or integrate with external app marketplaces.
    /// </remarks>
    [BusinessEvent(false)]
    procedure InvokeExtensionInstallation(AppId: Text; ResponseUrl: Text)
    begin
    end;

    /// <summary>
    /// Business event that is triggered when the last error page should be opened.
    /// </summary>
    /// <remarks>
    /// Use this event to implement custom error handling pages, integrate with external logging systems, or provide enhanced error reporting capabilities.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OpenLastErrorPage()
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to provide custom support information.
    /// </summary>
    /// <param name="Name">The name of the support contact or organization.</param>
    /// <param name="Email">The email address for support contact.</param>
    /// <param name="Url">The URL for support resources or portal.</param>
    /// <remarks>
    /// Use this event to customize support contact information, integrate with customer service systems, or provide context-specific support resources.
    /// </remarks>
    [BusinessEvent(false)]
    procedure GetSupportInformation(var Name: Text; var Email: Text; var Url: Text)
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to set the status of notifications.
    /// </summary>
    /// <param name="NotificationId">The GUID identifier of the notification.</param>
    /// <param name="Enable">Whether the notification should be enabled or disabled.</param>
    /// <remarks>
    /// Use this event to implement custom notification management, integrate with external notification systems, or apply user-specific notification preferences.
    /// </remarks>
    [BusinessEvent(false)]
    procedure SetNotificationStatus(NotificationId: Guid; Enable: Boolean)
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to get the status of notifications.
    /// </summary>
    /// <param name="NotificationId">The GUID identifier of the notification.</param>
    /// <param name="IsEnabled">Indicates whether the notification is currently enabled.</param>
    /// <remarks>
    /// Use this event to implement custom notification status retrieval, integrate with external notification systems, or provide user-specific notification status information.
    /// </remarks>
    [BusinessEvent(false)]
    procedure GetNotificationStatus(NotificationId: Guid; var IsEnabled: Boolean)
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to customize company change behavior.
    /// </summary>
    /// <param name="NewCompanyName">The name of the company to change to. Subscribers can modify this value to redirect to a different company.</param>
    /// <remarks>
    /// Use this event to implement custom company switching logic, apply validation rules, or integrate with multi-tenant management systems.
    /// </remarks>
    [BusinessEvent(false)]
    procedure ChangeCompany(var NewCompanyName: Text)
    begin
    end;

    /// <summary>
    /// Business event that is triggered when role-based setup experience should be opened.
    /// </summary>
    /// <remarks>
    /// Use this event to implement custom role-based setup flows, integrate with external configuration systems, or provide enhanced onboarding experiences.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OpenRoleBasedSetupExperience()
    begin
    end;

    /// <summary>
    /// Business event that is triggered when general setup experience should be opened.
    /// </summary>
    /// <remarks>
    /// Use this event to implement custom general setup flows, integrate with configuration management systems, or provide guided setup experiences.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OpenGeneralSetupExperience()
    begin
    end;

    /// <summary>
    /// Business event that is triggered when AppSource marketplace should be opened.
    /// </summary>
    /// <remarks>
    /// Use this event to implement custom marketplace integration, apply filtering for available apps, or integrate with external app discovery systems.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OpenAppSourceMarket()
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to control whether auto-start tours are enabled.
    /// </summary>
    /// <param name="IsEnabled">Indicates whether auto-start tours should be enabled. Subscribers can modify this value to control tour behavior.</param>
    /// <remarks>
    /// Use this event to implement conditional tour enabling based on user preferences, experience level, or business rules.
    /// </remarks>
    [BusinessEvent(false)]
    procedure GetAutoStartTours(var IsEnabled: Boolean)
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to control whether the legacy action bar is enabled.
    /// </summary>
    /// <param name="IsEnabled">Indicates whether the legacy action bar should be enabled. Subscribers can modify this value to control UI behavior.</param>
    /// <remarks>
    /// Use this event to implement conditional UI rendering, maintain compatibility with legacy customizations, or provide user-specific interface preferences.
    /// </remarks>
    [BusinessEvent(false)]
    procedure GetIsLegacyActionBarEnabled(var IsEnabled: Boolean)
    begin
    end;

    /// <summary>
    /// Business event for retrieving user tokens for authentication scenarios. This is an on-premises only event.
    /// </summary>
    /// <param name="Resource">The resource for which the token is requested.</param>
    /// <param name="Scenario">The scenario context for the token request.</param>
    /// <param name="Token">The authentication token to be returned. Subscribers should populate this value with the appropriate token.</param>
    /// <remarks>
    /// This event is only available in on-premises deployments and is used for custom authentication integration scenarios. Use this to integrate with external identity providers or custom authentication systems.
    /// </remarks>
    [Scope('OnPrem')]
    [NonDebuggable]
    [BusinessEvent(false)]
    procedure GetUserToken(Resource: Text; Scenario: Text; var Token: Text)
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to confirm privacy notice approval for specific integrations.
    /// </summary>
    /// <param name="PrivacyNoticeIntegrationName">The name of the integration requiring privacy notice approval.</param>
    /// <param name="IsApproved">Indicates whether the privacy notice has been approved by the user.</param>
    /// <remarks>
    /// Use this event to implement custom privacy consent workflows, integrate with external consent management systems, or apply compliance requirements for data processing.
    /// </remarks>
    [BusinessEvent(false)]
    procedure ConfirmPrivacyNoticeApproval(PrivacyNoticeIntegrationName: Text; var IsApproved: Boolean)
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to get the approval state of privacy notices for specific integrations.
    /// </summary>
    /// <param name="PrivacyNoticeIntegrationName">The name of the integration to check privacy notice approval state for.</param>
    /// <param name="PrivacyNoticeApprovalState">The current approval state of the privacy notice.</param>
    /// <remarks>
    /// Use this event to retrieve privacy consent status, implement compliance reporting, or control feature availability based on consent status.
    /// </remarks>
    [BusinessEvent(false)]
    procedure GetPrivacyNoticeApprovalState(PrivacyNoticeIntegrationName: Text; var PrivacyNoticeApprovalState: Integer)
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to provide Power Platform environment ID for specific scenarios.
    /// </summary>
    /// <param name="Scenario">The scenario context for which the environment ID is requested.</param>
    /// <param name="EnvironmentId">The Power Platform environment ID to be returned for the specified scenario.</param>
    /// <remarks>
    /// Use this event to implement custom Power Platform integration scenarios, manage multiple environments, or provide context-specific environment routing.
    /// </remarks>
    [BusinessEvent(false)]
    procedure GetPowerPlatformEnvironmentId(Scenario: Text; var EnvironmentId: Text)
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to specify the page ID for the performance troubleshooter.
    /// </summary>
    /// <param name="PageId">The ID of the page to use for performance troubleshooting.</param>
    /// <remarks>
    /// Use this event to implement custom performance troubleshooting pages or integrate with external performance monitoring tools.
    /// </remarks>
    [BusinessEvent(false)]
    procedure GetPerformanceTroubleshooterPageId(var PageId: Integer)
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to specify the page ID for profiler schedules management.
    /// </summary>
    /// <param name="PageId">The ID of the page to use for managing profiler schedules.</param>
    /// <remarks>
    /// Use this event to implement custom profiler schedule management pages or integrate with external profiling tools.
    /// </remarks>
    [BusinessEvent(false)]
    procedure GetProfilerSchedulesPageId(var PageId: Integer)
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to specify the page ID for finding entries.
    /// </summary>
    /// <param name="PageId">The ID of the page to use for finding entries.</param>
    /// <remarks>
    /// Use this event to implement custom entry finding pages or integrate with external search and navigation tools.
    /// </remarks>
    [BusinessEvent(false)]
    procedure GetFindEntriesPageId(var PageId: Integer)
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to specify the page ID for data search functionality.
    /// </summary>
    /// <param name="PageId">The ID of the page to use for data search.</param>
    /// <remarks>
    /// Use this event to implement custom data search pages or integrate with external search engines and data discovery tools.
    /// </remarks>
    [BusinessEvent(false)]
    procedure GetDataSearchPageId(var PageId: Integer)
    begin
    end;

    /// <summary>
    /// Business event that is triggered when the data search page should be opened with a specific search value.
    /// </summary>
    /// <param name="SearchValue">The search value to use when opening the data search page.</param>
    /// <remarks>
    /// Use this event to implement custom data search workflows, integrate with external search services, or provide enhanced search experiences.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OpenDataSearchPage(SearchValue: Text)
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to get the status of Copilot capabilities.
    /// </summary>
    /// <param name="Capability">The integer identifier of the Copilot capability to check.</param>
    /// <param name="IsEnabled">Indicates whether the specified Copilot capability is enabled.</param>
    /// <param name="AppId">The GUID of the app that provides the capability.</param>
    /// <param name="Silent">Indicates whether the check should be performed silently without user interaction.</param>
    /// <remarks>
    /// Use this event to implement custom Copilot capability management, control feature availability, or integrate with external AI services.
    /// </remarks>
    [BusinessEvent(false)]
    procedure GetCopilotCapabilityStatus(Capability: Integer; var IsEnabled: Boolean; AppId: Guid; Silent: Boolean)
    begin
    end;

    [Scope('OnPrem')]
    [BusinessEvent(false)]
    procedure GetCopilotCapabilityInfo(Capability: Integer; AppId: Guid; var CapabilityInfo: JsonObject)
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to provide data search setup information.
    /// </summary>
    /// <param name="SetupInfo">JSON array containing data search setup configuration information.</param>
    /// <remarks>
    /// Use this event to configure data search capabilities, integrate with external search services, or provide custom search configuration options.
    /// </remarks>
    [BusinessEvent(false)]
    procedure GetDataSearchSetup(var SetupInfo: JsonArray)
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to specify display page information for a given record.
    /// </summary>
    /// <param name="TableNo">The table number of the source record.</param>
    /// <param name="SystemId">The system ID of the source record.</param>
    /// <param name="DisplayPageId">The ID of the page to use for displaying the record.</param>
    /// <param name="DisplayTableNo">The table number to use for display purposes.</param>
    /// <param name="DisplaySystemId">The system ID to use for display purposes.</param>
    /// <remarks>
    /// Use this event to implement custom record display logic, redirect to specialized pages, or integrate with external data viewers.
    /// </remarks>
    [BusinessEvent(false)]
    procedure GetDisplayPageId(TableNo: Integer; SystemId: Guid; var DisplayPageId: Integer; var DisplayTableNo: Integer; var DisplaySystemId: Guid)
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to provide custom dimensions for Copilot feedback telemetry.
    /// </summary>
    /// <param name="CustomDimensions">JSON object containing custom dimensions to include in Copilot feedback telemetry.</param>
    /// <remarks>
    /// Use this event to enhance telemetry collection for Copilot feedback, provide additional context for analytics, or integrate with external feedback systems.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnCopilotFeedbackProperties(CustomDimensions: JsonObject)
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to provide custom dimensions for Copilot system action telemetry.
    /// </summary>
    /// <param name="CustomDimensions">JSON object containing custom dimensions to include in Copilot system action telemetry.</param>
    /// <remarks>
    /// Use this event to enhance telemetry collection for Copilot system actions, provide additional context for analytics, or integrate with external monitoring systems.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnCopilotSystemActionInvokedProperties(CustomDimensions: JsonObject)
    begin
    end;

    /// <summary>
    /// Gets page summary for a given Page ID and bookmark.
    /// </summary>
    /// <param name="PageId">The ID of the page to get summary for.</param>
    /// <param name="Bookmark">The bookmark identifying the specific record or context within the page.</param>
    /// <param name="Summary">The summary text for the specified page and bookmark.</param>
    /// <remarks>
    /// This on-premises event enables custom page summary generation for navigation and context purposes. Use this to provide intelligent page summaries for user assistance or navigation aids.
    /// </remarks>
    [Scope('OnPrem')]
    [BusinessEvent(false)]
    procedure GetPageSummary(PageId: Integer; Bookmark: Text; var Summary: Text)
    begin
    end;

    /// <summary>
    /// Gets page ID for the page that can be used to display an Agent Task Message.
    /// </summary>
    /// <param name="PageId">The ID of the page to use for displaying Agent Task Messages.</param>
    /// <remarks>
    /// This event is used as fallback when <see cref="IAgentMetadata.GetAgentTaskMessagePageId"/> is not implemented.
    /// Use this to provide alternative page routing for Agent Task Message display in scenarios where the primary interface is not available.
    /// </remarks>
    [Scope('OnPrem')]
    [BusinessEvent(false)]
    procedure GetAgentTaskMessagePageId(var PageId: Integer)
    begin
    end;
}