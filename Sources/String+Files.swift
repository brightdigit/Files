/**
*  Files
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

extension String {
  internal func removingPrefix(_ prefix: String) -> String {
    guard hasPrefix(prefix) else {
      return self
    }
    return String(dropFirst(prefix.count))
  }

  internal func removingSuffix(_ suffix: String) -> String {
    guard hasSuffix(suffix) else {
      return self
    }
    return String(dropLast(suffix.count))
  }

  internal func appendingSuffixIfNeeded(_ suffix: String) -> String {
    guard !hasSuffix(suffix) else {
      return self
    }
    return appending(suffix)
  }
}
