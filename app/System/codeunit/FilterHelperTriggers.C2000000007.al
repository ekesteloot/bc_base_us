// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Text;

/// <summary>
/// Provides business events for custom filter text processing and manipulation.
/// Enables extensions to customize filter creation and formatting for different data types.
/// </summary>
/// <remarks>
/// Contains events for filter text customization across various data types.
/// Essential for extensions requiring custom filter formatting or localization.
/// Supports filter customization for date, time, text, code, and integer data types.
/// </remarks>
codeunit 2000000007 "Filter Helper Triggers"
{
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    /// <summary>
    /// Business event for customizing datetime filter text formatting.
    /// Enables custom datetime filter creation and localization.
    /// </summary>
    /// <param name="DateTimeFilterText">DateTime filter text to be customized</param>
    /// <remarks>
    /// Raised when datetime filter text requires formatting or customization.
    /// </remarks>
    [BusinessEvent(false)]
    procedure MakeDateTimeFilter(var DateTimeFilterText: Text)
    begin
    end;

    /// <summary>
    /// Business event for customizing integer filter text formatting.
    /// Enables custom integer filter creation and localization.
    /// </summary>
    /// <param name="IntFilterText">Integer filter text to be customized</param>
    /// <remarks>
    /// Raised when integer filter text requires formatting or customization.
    /// </remarks>
    [BusinessEvent(false)]
    procedure MakeIntFilter(var IntFilterText: Text)
    begin
    end;

    /// <summary>
    /// Business event for customizing date filter text formatting.
    /// Enables custom date filter creation and localization.
    /// </summary>
    /// <param name="DateFilterText">Date filter text to be customized</param>
    /// <remarks>
    /// Raised when date filter text requires formatting or customization.
    /// </remarks>
    [BusinessEvent(false)]
    procedure MakeDateFilter(var DateFilterText: Text)
    begin
    end;

    /// <summary>
    /// Business event for customizing text filter text formatting.
    /// Enables custom text filter creation and localization.
    /// </summary>
    /// <param name="TextFilterText">Text filter text to be customized</param>
    /// <remarks>
    /// Raised when text filter text requires formatting or customization.
    /// </remarks>
    [BusinessEvent(false)]
    procedure MakeTextFilter(var TextFilterText: Text)
    begin
    end;

    /// <summary>
    /// Business event for customizing code filter text formatting.
    /// Enables custom code filter creation and localization.
    /// </summary>
    /// <param name="TextFilterText">Code filter text to be customized</param>
    /// <remarks>
    /// Raised when code filter text requires formatting or customization.
    /// </remarks>
    [BusinessEvent(false)]
    procedure MakeCodeFilter(var TextFilterText: Text)
    begin
    end;

    /// <summary>
    /// Business event for customizing time filter text formatting.
    /// Enables custom time filter creation and localization.
    /// </summary>
    /// <param name="TimeFilterText">Time filter text to be customized</param>
    /// <remarks>
    /// Raised when time filter text requires formatting or customization.
    /// </remarks>
    [BusinessEvent(false)]
    procedure MakeTimeFilter(var TimeFilterText: Text)
    begin
    end;
}

