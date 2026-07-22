/**
*  Files
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Foundation

/// Platform path helpers.
///
/// The library stores every path in a single canonical form that always uses the
/// forward slash (`/`) as its separator, regardless of platform. All of the
/// library's internal path logic (the folder trailing-slash invariant, `../`
/// resolution, parent derivation, child concatenation, and `==`) operates on that
/// canonical form. Native separators (`\` on Windows) are used only when a path is
/// handed to `FileManager` or `URL(fileURLWithPath:)`, via `nativePath`.
///
/// On every non-Windows platform each helper is the identity, so behavior there is
/// unchanged.
internal enum Path {
  /// The platform's native path separator (`\` on Windows, `/` elsewhere).
  #if os(Windows)
    internal static let nativeSeparator = "\\"
  #else
    internal static let nativeSeparator = "/"
  #endif

  /// The canonical root of the file system.
  ///
  /// On Windows this is the root of the current working volume (for example
  /// `C:/`), because Windows has no single filesystem root. Elsewhere it is `/`.
  internal static var rootPath: String {
    #if os(Windows)
      let cwd = FileManager.default.currentDirectoryPath.canonicalizedPath
      // A canonical Windows path starts with a drive letter, e.g. "C:/Users/…".
      if let colon = cwd.firstIndex(of: ":") {
        return String(cwd[...colon]) + "/"
      }
      return "/"
    #else
      return "/"
    #endif
  }
}

extension String {
  /// The path in the library's canonical (forward-slash) form.
  ///
  /// On Windows this rewrites native `\` separators to `/`; elsewhere it returns
  /// the string unchanged.
  internal var canonicalizedPath: String {
    #if os(Windows)
      return replacingOccurrences(of: "\\", with: "/")
    #else
      return self
    #endif
  }

  /// The path in the platform's native form, suitable for `FileManager` and
  /// `URL(fileURLWithPath:)`.
  ///
  /// On Windows this rewrites canonical `/` separators to `\`; elsewhere it
  /// returns the string unchanged.
  internal var nativePath: String {
    #if os(Windows)
      return replacingOccurrences(of: "/", with: "\\")
    #else
      return self
    #endif
  }

  /// Whether this canonical path represents a Windows volume root (`C:/` or `C:`).
  ///
  /// Always `false` on non-Windows platforms, where the sole root is `/`.
  internal var isDriveRoot: Bool {
    #if os(Windows)
      return count <= 3 && (hasSuffix(":/") || hasSuffix(":"))
    #else
      return false
    #endif
  }
}
