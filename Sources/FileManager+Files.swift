/**
*  Files
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Foundation

extension FileManager {
  internal func locationExists(at path: String, kind: LocationKind) -> Bool {
    var isFolder: ObjCBool = false

    // `path` is in canonical (forward-slash) form; convert at the FileManager boundary.
    guard fileExists(atPath: path.nativePath, isDirectory: &isFolder) else {
      return false
    }

    switch kind {
    case .file: return !isFolder.boolValue
    case .folder: return isFolder.boolValue
    }
  }
}
