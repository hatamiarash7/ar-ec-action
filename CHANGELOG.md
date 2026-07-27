# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- `working-directory` input to resolve the bundle file against another directory.
- `id`, `status` and `created-at` outputs, plus a job summary for each deployment.
- Verification of the ArvanCloud CLI archive against a pinned SHA-256 checksum.
- Support for `arm64` runners.
- CI workflow running ShellCheck, shfmt, hadolint, actionlint and markdownlint.

### Changed

- Inputs are passed as environment variables instead of container arguments, so
  the API token no longer appears on the command line.
- The image is built in two stages, leaving no download tooling in the runtime
  image.
- Failures now produce a GitHub error annotation instead of a bare exit code.

## [1.0.0]

### Added

- Initial release: deploy a bundle file to ArvanCloud Edge Computing.

[Unreleased]: https://github.com/hatamiarash7/ar-ec-action/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/hatamiarash7/ar-ec-action/releases/tag/v1.0.0
