/**
*  Files
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

extension Folder {
  /// Return whether this folder contains a given location as a direct child.
  /// - parameter location: The location to find.
  /// - returns: `true` if the location is a direct child of this folder.
  public func contains<T: Location>(_ location: T) -> Bool {
    switch T.kind {
    case .file: return containsFile(named: location.name)
    case .folder: return containsSubfolder(named: location.name)
    }
  }

  /// Move the contents of this folder to a new parent
  /// - Parameters:
  ///   - folder: The new parent folder to move this folder's contents to.
  ///   - includeHidden: Whether hidden files should be included (default: `false`).
  /// - throws: `LocationError` if the operation couldn't be completed.
  public func moveContents(to folder: Folder, includeHidden: Bool = false) throws(LocationError) {
    var files = self.files
    files.includeHidden = includeHidden
    try files.move(to: folder)

    var folders = subfolders
    folders.includeHidden = includeHidden
    try folders.move(to: folder)
  }

  /// Empty this folder, permanently deleting all of its contents. Use with caution.
  /// - parameter includeHidden: Whether hidden files should also be deleted (default: `false`).
  /// - throws: `LocationError` if the operation couldn't be completed.
  public func empty(includingHidden includeHidden: Bool = false) throws(LocationError) {
    var files = self.files
    files.includeHidden = includeHidden
    try files.delete()

    var folders = subfolders
    folders.includeHidden = includeHidden
    try folders.delete()
  }

  /// Return whether this folder doesn't contain any locations.
  /// - parameter includeHidden: Whether hidden files should be considered (default: `false`).
  /// - returns: `true` if the folder contains no matching locations.
  public func isEmpty(includingHidden includeHidden: Bool = false) -> Bool {
    var files = self.files
    files.includeHidden = includeHidden

    if files.first != nil {
      return false
    }

    var folders = subfolders
    folders.includeHidden = includeHidden
    return folders.first == nil
  }
}
