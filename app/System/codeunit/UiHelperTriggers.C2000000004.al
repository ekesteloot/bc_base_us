// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment;

/// <summary>
/// Provides business events for extending UI helper functionality including auto-formatting, caption translation, system indicators, and application language management.
/// </summary>
/// <remarks>
/// This codeunit serves as an extensibility layer for UI-related operations and formatting functions, enabling partners and developers to customize data presentation, implement localization features, integrate with external formatting systems, and control visual indicators. All events are business events that can be subscribed to by external extensions.
/// </remarks>
codeunit 2000000004 "UI Helper Triggers"
{
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to provide custom auto-format translations for data presentation.
    /// </summary>
    /// <param name="AutoFormatType">The type of auto-formatting to apply (numeric identifier for the format type).</param>
    /// <param name="AutoFormatExpr">The auto-format expression that defines the formatting rules.</param>
    /// <param name="Translation">The translated format string that should be applied. Subscribers can modify this value to provide custom formatting.</param>
    /// <remarks>
    /// Use this event to implement custom number formatting, currency formatting, or date/time formatting based on business rules, regional preferences, or integration with external formatting libraries.
    /// </remarks>
    [BusinessEvent(false)]
    procedure AutoFormatTranslate(AutoFormatType: Integer; AutoFormatExpr: Text[80]; var Translation: Text[80])
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to specify the default rounding precision for amounts.
    /// </summary>
    /// <param name="AmountRoundingPrecision">The decimal precision to use for amount rounding. Subscribers can modify this value to set custom rounding rules.</param>
    /// <remarks>
    /// Use this event to implement custom rounding strategies, comply with regional accounting standards, or integrate with external financial calculation systems.
    /// </remarks>
    [BusinessEvent(false)]
    procedure GetDefaultRoundingPrecision(var AmountRoundingPrecision: Decimal)
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to provide custom caption class translations for dynamic UI text.
    /// </summary>
    /// <param name="Language">The language identifier for which the translation is requested.</param>
    /// <param name="CaptionExpr">The caption expression that defines the text to be translated.</param>
    /// <param name="Translation">The translated caption text. Subscribers can modify this value to provide custom translations.</param>
    /// <remarks>
    /// Use this event to implement advanced localization features, provide context-sensitive translations, or integrate with external translation services for dynamic UI elements.
    /// </remarks>
    [BusinessEvent(false)]
    procedure CaptionClassTranslate(Language: Integer; CaptionExpr: Text[1024]; var Translation: Text[1024])
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to provide custom system indicator text and styling.
    /// </summary>
    /// <param name="Text">The text to display in the system indicator. Subscribers can modify this value to provide custom indicator text.</param>
    /// <param name="Style">The style to apply to the system indicator (Standard, Accent1-Accent9). Subscribers can modify this value to control visual appearance.</param>
    /// <remarks>
    /// Use this event to implement custom system status indicators, provide environment-specific branding, or integrate with external monitoring systems to display system health information.
    /// </remarks>
    [BusinessEvent(false)]
    procedure GetSystemIndicator(var Text: Text[250]; var Style: Option Standard,Accent1,Accent2,Accent3,Accent4,Accent5,Accent6,Accent7,Accent8,Accent9)
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to provide custom styling for cue fields based on their values.
    /// </summary>
    /// <param name="TableId">The ID of the table containing the cue field.</param>
    /// <param name="FieldNo">The field number of the cue field.</param>
    /// <param name="CueValue">The current value of the cue field.</param>
    /// <param name="StyleText">The style text to apply to the cue field. Subscribers can modify this value to control visual appearance based on the cue value.</param>
    /// <remarks>
    /// Use this event to implement dynamic cue styling based on business rules, thresholds, or KPI targets. Enable visual indicators for performance metrics, alerts, or status information.
    /// </remarks>
    [BusinessEvent(false)]
    procedure GetCueStyle(TableId: Integer; FieldNo: Integer; CueValue: Decimal; var StyleText: Text)
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to specify the application language.
    /// </summary>
    /// <param name="Language">The language identifier for the application. Subscribers can modify this value to control the application language.</param>
    /// <remarks>
    /// Use this event to implement custom language selection logic, integrate with user preference systems, or control application language based on business rules or regional settings.
    /// </remarks>
    [BusinessEvent(false)]
    procedure GetApplicationLanguage(var Language: Integer)
    begin
    end;
}

