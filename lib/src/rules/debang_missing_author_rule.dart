import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

/// Analysis rule that checks debang assertions have an author name,
/// similar to the `TODO(username)` convention.
///
/// Valid:   debang('(john): temporary workaround for X')
/// Invalid: debang('temporary workaround for X')
class DebangMissingAuthorRule extends AnalysisRule {
  /// Creates a new instance with the specified [severity].
  DebangMissingAuthorRule({
    required this.severity,
  }) : super(
          name: ruleName,
          description: _description,
        );

  /// Diagnostic severity level (ERROR, WARNING, INFO, or HINT).
  final DiagnosticSeverity severity;

  /// The unique name identifier for this rule.
  static const String ruleName = 'debang_missing_author';

  static const String _description =
      'Checks that debang messages include an author name, e.g. (username): assertion';

  /// Regex matching the `TODO(username)` style prefix: (name):
  /// Name may contain letters, digits, dots, underscores, hyphens.
  static final RegExp _authorPattern = RegExp(r'^\([a-zA-Z0-9._-]+\):');

  @override
  LintCode get diagnosticCode => LintCode(
        ruleName,
        'Debang assertion is missing an author name.',
        uniqueName: 'debang.$ruleName',
        correctionMessage:
            "Add your name in parentheses before the message, e.g. '(username): assertion'.",
        severity: severity,
      );

  @override
  void registerNodeProcessors(
      RuleVisitorRegistry registry, RuleContext context) {
    final visitor = _Visitor(rule: this, context: context);
    registry.addMethodInvocation(this, visitor);
    registry.addInstanceCreationExpression(this, visitor);
  }
}

/// AST visitor that checks debang calls for the (username): prefix.
class _Visitor extends SimpleAstVisitor<void> {
  _Visitor({
    required this.rule,
    required this.context,
  });

  final DebangMissingAuthorRule rule;
  final RuleContext context;

  @override
  void visitMethodInvocation(MethodInvocation node) {
    if (node.methodName.name != 'debang') return;

    final args = node.argumentList.arguments;
    if (args.isEmpty) return;

    _checkAuthor(args.first);
  }

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final typeName = node.constructorName.type.name.lexeme;
    if (typeName != 'Debang') return;
    if (node.constructorName.name != null) return;

    final args = node.argumentList.arguments;
    if (args.isEmpty) return;

    _checkAuthor(args.first);
  }

  /// Reports a diagnostic if the message does not start with (username):.
  void _checkAuthor(Expression expr) {
    if (expr is! StringLiteral) return;

    final message = expr.stringValue?.trim();
    if (message == null || message.isEmpty) {
      final unit = context.currentUnit;
      if (unit == null) return;
      unit.diagnosticReporter.atNode(expr, rule.diagnosticCode);
      return;
    }

    if (DebangMissingAuthorRule._authorPattern.hasMatch(message)) return;

    final unit = context.currentUnit;
    if (unit == null) return;

    unit.diagnosticReporter.atNode(expr, rule.diagnosticCode);
  }
}
