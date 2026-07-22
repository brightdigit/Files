/**
*  Files
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

public enum WriteErrorReason: Sendable {
  /// An empty path was given when writing or creating a location.
  case emptyPath
  /// A folder couldn't be created because of an underlying system error.
  case folderCreationFailed(any Error & Sendable)
  /// A file couldn't be created.
  case fileCreationFailed
  /// A file couldn't be written to because of an underlying system error.
  case writeFailed(any Error & Sendable)
  /// Failed to encode a string into binary data.
  case stringEncodingFailed(String)
}
