// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Tooling;

/// <summary>
/// Provides business events for extending SmartList Designer functionality and managing query-based list creation workflows.
/// </summary>
/// <remarks>
/// This codeunit serves as an extensibility layer for the SmartList Designer tool, enabling partners and developers to customize list creation behavior, handle query operations, and integrate with external data visualization tools. All events are business events that can be subscribed to by external extensions.
/// </remarks>
codeunit 2000000011 "SmartList Designer Triggers"
{
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to control whether SmartList Designer functionality is enabled.
    /// </summary>
    /// <param name="Enabled">Indicates whether SmartList Designer should be enabled. Subscribers can modify this value to control feature availability.</param>
    /// <remarks>
    /// Use this event to implement conditional enabling of SmartList Designer based on licensing, user permissions, or environment configuration.
    /// </remarks>
    [BusinessEvent(false)]
    procedure GetEnabled(var Enabled: Boolean)
    begin
    end;

    /// <summary>
    /// Obsolete business event for creating SmartLists based on a table. Use OnCreateNewForTableAndView instead.
    /// </summary>
    /// <param name="TableId">The ID of the table for which to create a SmartList.</param>
    /// <remarks>
    /// This event is obsolete. Use OnCreateNewForTableAndView instead which provides enhanced functionality with view support.
    /// </remarks>
    [BusinessEvent(false)]
    [Obsolete('Use OnCreateNewForTableAndView instead')]
    procedure OnCreateForTable(TableId: Integer)
    begin
    end;

    /// <summary>
    /// Business event that is triggered when creating a new SmartList for a specific table and view combination.
    /// </summary>
    /// <param name="TableId">The ID of the table for which to create a SmartList.</param>
    /// <param name="ViewId">The identifier of the view to be used for the SmartList creation.</param>
    /// <remarks>
    /// Use this event to customize SmartList creation behavior, apply default settings, or integrate with external list management systems when creating lists for specific table and view combinations.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnCreateNewForTableAndView(TableId: Integer; ViewId: Text)
    begin
    end;

    /// <summary>
    /// Business event that is triggered when editing a query in SmartList Designer.
    /// </summary>
    /// <param name="QueryId">The identifier of the query being edited.</param>
    /// <remarks>
    /// Use this event to implement custom query editing behavior, apply validation rules, or integrate with external query design tools.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnEditQuery(QueryId: Text)
    begin
    end;

    /// <summary>
    /// Business event that is triggered when an invalid query navigation is attempted.
    /// </summary>
    /// <param name="Id">The identifier of the invalid query or navigation target.</param>
    /// <remarks>
    /// Use this event to handle error scenarios when query navigation fails, provide alternative navigation paths, or log invalid navigation attempts for debugging purposes.
    /// </remarks>
    [BusinessEvent(false)]
    procedure OnInvalidQueryNavigation(Id: BigInteger)
    begin
    end;
}