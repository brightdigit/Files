/**
*  Files
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

extension Folder {
  /// Return a subfolder at a given path within this folder.
  /// - parameter path: A relative path within this folder.
  /// - throws: `LocationError` if the subfolder couldn't be found.
  /// - returns: The subfolder located at the given path.
  public func subfolder(at path: String) throws(LocationError) -> Folder {
    try storage.subfolder(at: path)
  }

  /// Return a subfolder with a given name.
  /// - parameter name: The name of the subfolder to return.
  /// - throws: `LocationError` if the subfolder couldn't be found.
  /// - returns: The subfolder with the given name.
  public func subfolder(named name: String) throws(LocationError) -> Folder {
    try storage.subfolder(at: name)
  }

  /// Return whether this folder contains a subfolder at a given path.
  /// - parameter path: The relative path of the subfolder to look for.
  /// - returns: `true` if a subfolder exists at the given path.
  public func containsSubfolder(at path: String) -> Bool {
    (try? subfolder(at: path)) != nil
  }

  /// Return whether this folder contains a subfolder with a given name.
  /// - parameter name: The name of the subfolder to look for.
  /// - returns: `true` if a subfolder with the given name exists.
  public func containsSubfolder(named name: String) -> Bool {
    (try? subfolder(named: name)) != nil
  }

  /// Create a new subfolder at a given path within this folder. In case
  /// the intermediate folders between this folder and the new one don't
  /// exist, those will be created as well. This method throws an error
  /// if a folder already exists at the given path.
  /// - parameter path: The relative path of the subfolder to create.
  /// - throws: `WriteError` if the operation couldn't be completed.
  /// - returns: The newly created subfolder.
  @discardableResult
  public func createSubfolder(at path: String) throws(WriteError) -> Folder {
    try storage.createSubfolder(at: path)
  }

  /// Create a new subfolder with a given name. This method throws an error
  /// if a subfolder with the given name already exists.
  /// - parameter name: The name of the subfolder to create.
  /// - throws: `WriteError` if the operation couldn't be completed.
  /// - returns: The newly created subfolder.
  @discardableResult
  public func createSubfolder(named name: String) throws(WriteError) -> Folder {
    try storage.createSubfolder(at: name)
  }

  /// Create a new subfolder at a given path within this folder. In case
  /// the intermediate folders between this folder and the new one don't
  /// exist, those will be created as well. If a folder already exists at
  /// the given path, then it will be returned without modification.
  /// - parameter path: The relative path of the subfolder.
  /// - throws: `WriteError` if a new folder couldn't be created.
  /// - returns: The existing or newly created subfolder.
  @discardableResult
  public func createSubfolderIfNeeded(at path: String) throws(WriteError) -> Folder {
    if let existing = try? subfolder(at: path) {
      return existing
    }
    return try createSubfolder(at: path)
  }

  /// Create a new subfolder with a given name. If a subfolder with the given
  /// name already exists, then it will be returned without modification.
  /// - parameter name: The name of the subfolder.
  /// - throws: `WriteError` if a new folder couldn't be created.
  /// - returns: The existing or newly created subfolder.
  @discardableResult
  public func createSubfolderIfNeeded(withName name: String) throws(WriteError) -> Folder {
    if let existing = try? subfolder(named: name) {
      return existing
    }
    return try createSubfolder(named: name)
  }
}
