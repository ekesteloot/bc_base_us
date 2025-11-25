// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------

namespace System.MCP;

/// <summary>
/// Provides functionality for managing MCP configurations.
/// </summary>
codeunit 2000000023 "MCP Utilities"
{
    Access = Internal;

    /// <summary>
    /// Get list of invalid MCP tools missing parent pages for the provided list of page tool object IDs.
    /// </summary>
    /// <param name="PageObjectIds">List of page object IDs.</param>
    /// <returns>List of invalid MCP tool page IDs.</returns>
    [Native]
    procedure GetInvalidMCPToolsMissingParentPage(PageObjectIds: List of [Integer]): List of [Integer]
    begin
    end;

    /// <summary>
    /// Get list of parent MCP tools for the provided list of page tool object IDs.
    /// </summary>
    /// <param name="PageObjectId">Page object ID.</param>
    /// <returns>List of parent MCP tool page IDs.</returns>
    [Native]
    procedure GetParentMCPTools(PageObjectId: Integer): List of [Integer]
    begin
    end;
}