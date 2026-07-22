/**
*  Files
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Foundation

/// Enum listing reasons that a location manipulation could fail.
public enum LocationErrorReason: Sendable {
  /// The location couldn't be found.
  case missing
  /// An empty path was given when refering to a file.
  case emptyFilePath
  /// The user attempted to rename the file system's root folder.
  case cannotRenameRoot
  /// A rename operation failed with an underlying system error.
  case renameFailed(any Error & Sendable)
  /// A move operation failed with an underlying system error.
  case moveFailed(any Error & Sendable)
  /// A copy operation failed with an underlying system error.
  case copyFailed(any Error & Sendable)
  /// A delete operation failed with an underlying system error.
  case deleteFailed(any Error & Sendable)
  /// A search path couldn't be resolved within a given domain.
  case unresolvedSearchPath(
    FileManager.SearchPathDirectory,
    domain: FileManager.SearchPathDomainMask
  )
}
