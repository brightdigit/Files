/**
*  Files
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Foundation

extension Folder {
  /// A sequence of child locations contained within a given folder.
  /// You obtain an instance of this type by accessing either `files`
  /// or `subfolders` on a `Folder` instance.
  public struct ChildSequence<Child: Location>: Sequence {
    internal let folder: Folder
    internal let fileManager: FileManager
    internal var isRecursive: Bool
    internal var includeHidden: Bool

    /// Create an iterator that traverses this sequence's child locations.
    /// - returns: A new iterator over the sequence's contents.
    public func makeIterator() -> ChildIterator<Child> {
      ChildIterator(
        folder: folder,
        fileManager: fileManager,
        isRecursive: isRecursive,
        includeHidden: includeHidden,
        reverseTopLevelTraversal: false
      )
    }
  }

  /// The type of iterator used by `ChildSequence`. You don't interact
  /// with this type directly. See `ChildSequence` for more information.
  public struct ChildIterator<Child: Location>: IteratorProtocol {
    private let folder: Folder
    private let fileManager: FileManager
    private let isRecursive: Bool
    private let includeHidden: Bool
    private let reverseTopLevelTraversal: Bool
    private lazy var itemNames = loadItemNames()
    private var index = 0
    private var nestedIterators = [ChildIterator<Child>]()

    internal init(
      folder: Folder,
      fileManager: FileManager,
      isRecursive: Bool,
      includeHidden: Bool,
      reverseTopLevelTraversal: Bool
    ) {
      self.folder = folder
      self.fileManager = fileManager
      self.isRecursive = isRecursive
      self.includeHidden = includeHidden
      self.reverseTopLevelTraversal = reverseTopLevelTraversal
    }

    // swiftlint:disable cyclomatic_complexity
    /// Advance to and return the next child location, or `nil` when the
    /// sequence has been exhausted.
    /// - returns: The next child location, or `nil` if there are no more.
    public mutating func next() -> Child? {
      guard index < itemNames.count else {
        guard var nested = nestedIterators.first else {
          return nil
        }

        guard let child = nested.next() else {
          nestedIterators.removeFirst()
          return next()
        }

        nestedIterators[0] = nested
        return child
      }

      let name = itemNames[index]
      index += 1

      if !includeHidden {
        guard !name.hasPrefix(".") else {
          return next()
        }
      }

      let childPath = folder.path + name.removingPrefix("/")
      let childStorage = try? Storage<Child>(path: childPath)
      let child = childStorage.map(Child.init)

      if isRecursive {
        let childFolder =
          (child as? Folder)
          ?? (try? Folder(
            storage: Storage(path: childPath)
          ))

        if let childFolder = childFolder {
          let nested = ChildIterator(
            folder: childFolder,
            fileManager: fileManager,
            isRecursive: true,
            includeHidden: includeHidden,
            reverseTopLevelTraversal: false
          )

          nestedIterators.append(nested)
        }
      }

      return child ?? next()
    }
    // swiftlint:enable cyclomatic_complexity

    private mutating func loadItemNames() -> [String] {
      let contents = try? fileManager.contentsOfDirectory(atPath: folder.path.nativePath)
      let names = contents?.sorted() ?? []
      return reverseTopLevelTraversal ? names.reversed() : names
    }
  }
}

extension Folder.ChildSequence: CustomStringConvertible {
  /// A textual representation of the sequence, listing each child's
  /// description on its own line.
  public var description: String {
    lazy.map({ $0.description }).joined(separator: "\n")
  }
}
