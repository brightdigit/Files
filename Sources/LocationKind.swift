/**
*  Files
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

/// Enum describing various kinds of locations that can be found on a file system.
public enum LocationKind: Sendable {
  /// A file can be found at the location.
  case file
  /// A folder can be found at the location.
  case folder
}
