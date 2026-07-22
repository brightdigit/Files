/**
*  Files
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

public enum LocationKind: Sendable {
  /// A file can be found at the location.
  case file
  /// A folder can be found at the location.
  case folder
}
