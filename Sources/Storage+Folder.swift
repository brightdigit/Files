/**
*  Files
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Foundation

extension Storage where LocationType == Folder {
  internal func makeChildSequence<T: Location>() -> Folder.ChildSequence<T> {
    Folder.ChildSequence(
      folder: Folder(storage: self),
      fileManager: .default,
      isRecursive: false,
      includeHidden: false
    )
  }

  internal func subfolder(at folderPath: String) throws(LocationError) -> Folder {
    let folderPath = path + folderPath.canonicalizedPath.removingPrefix("/")
    let storage = try Storage(path: folderPath)
    return Folder(storage: storage)
  }

  internal func file(at filePath: String) throws(LocationError) -> File {
    let filePath = path + filePath.canonicalizedPath.removingPrefix("/")
    let storage = try Storage<File>(path: filePath)
    return File(storage: storage)
  }

  internal func createSubfolder(at folderPath: String) throws(WriteError) -> Folder {
    let folderPath = path + folderPath.canonicalizedPath.removingPrefix("/")

    guard folderPath != path else {
      throw WriteError(path: folderPath, reason: .emptyPath)
    }

    do {
      try FileManager.default.createDirectory(
        atPath: folderPath.nativePath,
        withIntermediateDirectories: true
      )

      let storage = try Storage(path: folderPath)
      return Folder(storage: storage)
    } catch {
      throw WriteError(path: folderPath, reason: .folderCreationFailed(error))
    }
  }

  internal func createFile(at filePath: String, contents: Data?) throws(WriteError) -> File {
    let filePath = path + filePath.canonicalizedPath.removingPrefix("/")

    guard let parentPath = makeParentPath(for: filePath) else {
      throw WriteError(path: filePath, reason: .emptyPath)
    }

    if parentPath != path {
      do {
        try FileManager.default.createDirectory(
          atPath: parentPath.nativePath,
          withIntermediateDirectories: true
        )
      } catch {
        throw WriteError(path: parentPath, reason: .folderCreationFailed(error))
      }
    }

    guard FileManager.default.createFile(atPath: filePath.nativePath, contents: contents),
      let storage = try? Storage<File>(path: filePath)
    else {
      throw WriteError(path: filePath, reason: .fileCreationFailed)
    }

    return File(storage: storage)
  }
}
