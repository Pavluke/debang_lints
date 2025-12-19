/// Analyzer plugin for the `debang` package.
///
/// Enforces minimum message length for `debang()` calls to ensure
/// descriptive debug messages.
///
/// ## Enable in a project
///
/// Add to `analysis_options.yaml`:
///
/// ```
/// plugins:
///   debang_lints: ^1.0.0
/// ```
///
/// Then restart Analysis Server in your IDE.
///
/// ## Provided diagnostic
///
/// ### debang_message_too_short
///
/// Reports when the message argument is shorter than the configured minimum:
///
/// ```
/// value.debang("Won't be null");  // ❌ Too short
/// value.debang("Value won't be null because it's initialized after authorization.");  // ✅ OK
/// ```
library;

import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';
import 'package:analyzer/error/error.dart';

import 'src/src.dart';

/// The plugin instance that the Dart Analysis Server loads.
///
/// This top-level variable must be present for the analyzer to detect
/// and load the plugin.
final Plugin plugin = DebangLintPlugin();

/// Main plugin class that registers custom analysis rules.
class DebangLintPlugin extends Plugin {
  @override
  String get name => 'debang_lints';

  @override
  void register(PluginRegistry registry) {
    registry.registerWarningRule(
      DebangAssertionTooShortRule(
        minLength: 32,
        severity: DiagnosticSeverity.ERROR,
      ),
    );
  }
}
