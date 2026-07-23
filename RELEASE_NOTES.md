# Release Notes

This is a BrightDigit fork of [Files](https://github.com/JohnSundell/Files) by John Sundell,
maintained for the BrightDigit site toolchain. Original work © John Sundell; modifications
© 2026 BrightDigit, distributed under the original MIT License.

## Unreleased

Onboards the fork onto the BrightDigit toolchain and Swift 6.4 CI (PR #1,
"Sync subrepo branch brightdigit-com-260406", part of the monorepo subrepo maintenance sweep):

- Swift 6.4 migration: `Package.swift`, `.swift-version`, and the source/test tree moved onto
  the BrightDigit Swift 6.4 stack with strict concurrency.
- Standalone CI: adds the BrightDigit CI template (`.github/workflows/Files.yml` plus Claude
  review/automation workflows and `setup-tools`) running Linux, macOS, Apple platforms,
  Windows, and Android on nightly Swift 6.4.
- Tooling: `.mise.toml`, `.swift-format`, `.swiftlint.yml`, `.periphery.yml`, `.spi.yml`,
  `.devcontainer`, `Scripts/lint.sh`, and `Scripts/header.sh` added/normalized for the
  BrightDigit house style.
- Fork attribution preserved: John Sundell's original MIT copyright and per-file headers and
  the LICENSE are kept verbatim; a root `NOTICE`, a README fork note, and a guard in
  `Scripts/header.sh` protect the upstream headers from being rewritten.
