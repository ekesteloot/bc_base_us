// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------

namespace System;

/// <summary>
/// Provides a common base interface that can be implemented by other interfaces for polymorphic behavior.
/// Serves as an optional foundation interface for implementing common interface patterns.
/// </summary>
/// <remarks>
/// This interface follows the IUnknown pattern commonly used in component-oriented programming.
/// Can be used as a base interface when implementing interface hierarchies or when requiring
/// a common interface type for polymorphic operations across different interface implementations.
/// Contains no methods, serving purely as a marker interface for type compatibility.
/// </remarks>
interface IUnknown
{
}