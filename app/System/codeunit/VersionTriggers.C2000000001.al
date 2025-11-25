// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace System.Environment;

/// <summary>
/// Provides business events for retrieving application version information including application version, release version, and build information.
/// </summary>
/// <remarks>
/// This codeunit serves as an extensibility layer for version management functionality, enabling partners and developers to customize version reporting, integrate with external version tracking systems, and implement custom version validation logic. All events are business events that can be subscribed to by external extensions.
/// </remarks>
codeunit 2000000001 "Version Triggers"
{
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to provide the application version information.
    /// </summary>
    /// <param name="Version">The application version string. Subscribers can modify this value to provide custom version information.</param>
    /// <remarks>
    /// Use this event to implement custom version reporting, integrate with external version management systems, or provide enhanced version information that includes custom build details or deployment-specific identifiers.
    /// </remarks>
    [BusinessEvent(false)]
    procedure GetApplicationVersion(var Version: Text[248])
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to provide the release version information.
    /// </summary>
    /// <param name="Version">The release version string. Subscribers can modify this value to provide custom release version information.</param>
    /// <remarks>
    /// Use this event to implement custom release version reporting, integrate with release management systems, or provide enhanced release information that includes deployment-specific details or hotfix identifiers.
    /// </remarks>
    [BusinessEvent(false)]
    procedure GetReleaseVersion(var Version: Text[50])
    begin
    end;

    /// <summary>
    /// Business event that allows subscribers to provide the application build information.
    /// </summary>
    /// <param name="Build">The application build string. Subscribers can modify this value to provide custom build information.</param>
    /// <remarks>
    /// Use this event to implement custom build reporting, integrate with continuous integration systems, or provide enhanced build information that includes commit identifiers, build timestamps, or deployment pipeline details.
    /// </remarks>
    [BusinessEvent(false)]
    procedure GetApplicationBuild(var Build: Text[80])
    begin
    end;
}

