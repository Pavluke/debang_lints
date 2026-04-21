# Debang Lints

[![Pub](https://img.shields.io/pub/v/debang_lints.svg)](https://pub.dartlang.org/packages/debang_lints)

**En** | [Ru](README_RU.md)

A custom Dart analyzer plugin that enforces quality standards for `debang()` calls.

## About Debang

[`debang`](https://github.com/pavluke/debang) is a debugging package that
provides the `.debang()` extension for nullable types with assertion messages
and a `Debang()` constructor for providing default values. This linter ensures
all assertion messages are descriptive and meaningful.

<p align="center">For better understanding how it works check <a href="https://pavluke.github.io/packages/?pkg=debang_lints">demo</a> page</p>

<div align="center">
  <a href="https://pavluke.github.io/packages/?pkg=debang_lints" 
     style="background: #10ac84; color: white; padding: 12px 24px; 
            text-decoration: none; border-radius: 6px; 
            font-weight: bold; display: inline-block;">
    Open Demo
  </a>
</div>

## Overview

This plugin helps maintain code quality by ensuring that all debug messages
passed to `debang()` are descriptive and useful. Short, cryptic messages like
`''` (empty string) or `'won't be null'` are flagged, and messages without an
author name are reported — encouraging developers to write accountable,
meaningful debug output.

## Rules

| Rule | Description | Default |
|---|---|---|
| `debang_message_too_short` | Message must meet a minimum character length | disabled |
| `debang_missing_author` | Message must start with an author name `(username):` | disabled |

## Installation

### 1. Add to `analysis_options.yaml`

```yaml
plugins:
  debang_lints: ^1.1.0
```

> **Note:** Lint rules are disabled by default in the new Dart analyzer plugin
> system. You must explicitly enable each rule under `diagnostics:`.

### 2. Restart Analysis Server

Run `dart pub get`, then:

**VS Code:** Command Palette → `Dart: Restart Analysis Server`

**IntelliJ/Android Studio:** File → Invalidate Caches / Restart

## Usage Examples

### `debang_message_too_short`

#### ❌ Bad (triggers diagnostic)

```dart
import 'package:debang/debang.dart';

void main() {
  int? value;
  value.debang("Won't be null");  // Error: assertion message too short
}
```

#### ✅ Good (passes validation)

```dart
import 'package:debang/debang.dart';

void main() {
  int? value;
  value.debang(
    "Value won't be null because it is written after authorization into local storage."
  );  // OK
}
```

---

### `debang_missing_author`

Messages must begin with `(username):`, similar to the `TODO(username):` convention.

#### ❌ Bad (triggers diagnostic)

```dart
import 'package:debang/debang.dart';

void main() {
  int? value;
  value.debang("Won't be null after auth");  // Error: missing author name
}
```

#### ✅ Good (passes validation)

```dart
import 'package:debang/debang.dart';

void main() {
  int? value;
  value.debang("(John Doe): Won't be null after auth flow completes");  // OK
}
```

## Changelog

The list of changes is available in
[CHANGELOG.md](https://github.com/pavluke/debang_lints/blob/main/CHANGELOG.md).

## Contributions

Feel free to contribute to this project. If you find a bug or want to add a new
feature but don't know how to fix/implement it, please open an
[issue](https://github.com/pavluke/debang_lints/issues). If you fixed a bug or
implemented a feature, please submit a
[pull request](https://github.com/pavluke/debang_lints/pulls).

## License

MIT License — see the LICENSE file for details.
