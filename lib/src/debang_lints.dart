import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';
import 'package:analyzer/error/error.dart';

import 'src.dart';

/// Main plugin class that registers custom analysis rules.
class DebangLintPlugin extends Plugin {
  /// Creates a new instance of [DebangLintPlugin].
  DebangLintPlugin();

  @override
  String get name => 'debang_lints';

  @override
  void register(PluginRegistry registry) {
    registry
      ..registerWarningRule(
        DebangAssertionTooShortRule(
          minLength: 32,
          severity: DiagnosticSeverity.ERROR,
        ),
      )
      ..registerWarningRule(
        DebangMissingAuthorRule(
          severity: DiagnosticSeverity.ERROR,
        ),
      );
  }
}
