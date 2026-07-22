/**
*  Files
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

public typealias LocationError = FilesError<LocationErrorReason>
/// Error thrown by write operations - such as file/folder creation.
public typealias WriteError = FilesError<WriteErrorReason>
/// Error thrown by read operations - such as when reading a file's contents.
public typealias ReadError = FilesError<ReadErrorReason>

/// Error type thrown by all of Files' throwing APIs.
public struct FilesError<Reason: Sendable>: Error {
  /// The absolute path that the error occured at.
  public var path: String
  /// The reason that the error occured.
  public var reason: Reason

  /// Initialize an instance with a path and a reason.
  /// - Parameters:
  ///   - path: The absolute path that the error occured at.
  ///   - reason: The reason that the error occured.
  public init(path: String, reason: Reason) {
    self.path = path
    self.reason = reason
  }
}

extension FilesError: CustomStringConvertible {
  /// A textual representation of the error, including its path and reason.
  public var description: String {
    """
    Files encountered an error at '\(path)'.
    Reason: \(reason)
    """
  }
}
