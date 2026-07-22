/**
*  Files
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

/// Enum listing reasons that a read operation could fail.
public enum ReadErrorReason: Sendable {
  /// A file couldn't be read because of an underlying system error.
  case readFailed(any Error & Sendable)
  /// Failed to decode a given set of data into a string.
  case stringDecodingFailed
  /// Encountered a string that doesn't contain an integer.
  case notAnInt(String)
}
