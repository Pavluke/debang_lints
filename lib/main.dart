/// Analyzer plugin for the `debang` package.
///
/// Enforces minimum message length for `debang()` or `Debang()` calls to ensure
/// descriptive debug messages.
///
/// ## Enable in a project
///
/// Add to `analysis_options.yaml`:
///
/// ```
/// plugins:
///   debang_lints: ^1.1.0
/// ```
///
/// Then restart Analysis Server in your IDE.
///
/// ```
/// value.debang("Won't be null");  // ❌ Too short
/// value.debang("Value won't be null because it's initialized after authorization.");  // ✅ OK
/// ```
library;

import 'package:analysis_server_plugin/plugin.dart';

import 'src/src.dart';

export 'src/src.dart';

/// The plugin instance that the Dart Analysis Server loads.
///
/// This top-level variable must be present for the analyzer to detect
/// and load the plugin.
final Plugin plugin = DebangLintPlugin();
