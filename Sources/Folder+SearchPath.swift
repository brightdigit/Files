/**
*  Files
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Foundation

#if os(iOS) || os(tvOS) || os(macOS)
  extension Folder {
    /// The current user's Documents folder
    public static var documents: Folder? {
      try? .matching(.documentDirectory)
    }

    /// The current user's Library folder
    public static var library: Folder? {
      try? .matching(.libraryDirectory)
    }

    /// Resolve a folder that matches a search path within a given domain.
    /// - Parameters:
    ///   - searchPath: The directory path to search for.
    ///   - domain: The domain to search in.
    ///   - fileManager: Which file manager to search using.
    /// - throws: `LocationError` if no folder could be resolved.
    /// - returns: The resolved folder for the given search path.
    public static func matching(
      _ searchPath: FileManager.SearchPathDirectory,
      in domain: FileManager.SearchPathDomainMask = .userDomainMask,
      resolvedBy fileManager: FileManager = .default
    ) throws -> Folder {
      let urls = fileManager.urls(for: searchPath, in: domain)

      guard let match = urls.first else {
        throw LocationError(
          path: "",
          reason: .unresolvedSearchPath(searchPath, domain: domain)
        )
      }

      return try Folder(storage: Storage(path: match.relativePath))
    }
  }
#endif
