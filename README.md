# Debang Lints

[![Pub](https://img.shields.io/pub/v/debang_lints.svg)](https://pub.dartlang.org/packages/debang_lints)

[En](README.md) | **Ru**

A custom Dart analyzer plugin that enforces minimum message length for
`debang()` calls.

## About Debang

[`debang`](https://github.com/pavluke/debang) is a debugging package that
provides the `.debang()` extension for nullable types with assertion messages
and a `Debang()` constructor for providing default values. This linter ensures
all assertion messages are descriptive and meaningful.

## Overview

This plugin helps maintain code quality by ensuring that all debug messages
passed to `debang()` are descriptive and useful. Short, cryptic messages like
`''` (empty string) or `'won't be null'` are flagged, encouraging developers to
write meaningful debug output.

## Features

- ✅ Validates message length for `Debang()` constructor
- ✅ Validates message length for `.debang()` extension calls
- ✅ Works in IDE (VS Code, IntelliJ, Android Studio)
- ✅ Works with `dart analyze` CLI
- ✅ Compatible with CI/CD pipelines

## Installation

### 1. Add to your project

**analysis_options.yaml:**

```yaml
plugins:
  debang_lints: ^1.0.0
```

### 2. Restart Analysis Server

Run `dart pub get`, then:

**VS Code:** Command Palette → `Dart: Restart Analysis Server`

**IntelliJ/Android Studio:** File → Invalidate Caches / Restart

## Usage Examples

### ❌ Bad (triggers diagnostic)

```dart
import 'package:debang/debang.dart';

void main() {
  int? value;

  value.debang('');  // Error: assertion message too short

  final result = value ?? Debang("won't be null");  // Error: assertion message too short
}
```

### ✅ Good (passes validation)

```dart
import 'package:debang/debang.dart';

void main() {
  int? value;

  value.debang("Value won't be null because it write after authorization into local storage.");  // OK
}
```

## Changelog

The list of changes is available in the file
[CHANGELOG.md](https://github.com/pavluke/debang_lints/blob/main/CHANGELOG.md)

## Contributions

Feel free to contribute to this project. If you find a bug or want to add a new
feature but don't know how to fix/implement it, please write in
[issues](https://github.com/pavluke/debang_lints/issues). If you fixed a bug or
implemented some feature, please make
[pull request](https://github.com/pavluke/debang_lints/pulls).

## License

MIT License - see LICENSE file for details
