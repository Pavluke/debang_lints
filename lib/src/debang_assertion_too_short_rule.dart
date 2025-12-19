import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

/// Analysis rule that checks minimum message length for debang assertions.
class DebangAssertionTooShortRule extends AnalysisRule {
  /// Creates a new instance with the specified [minLength] and [severity].
  DebangAssertionTooShortRule({
    required this.minLength,
    required this.severity,
  }) : super(
          name: ruleName,
          description: _description,
        );

  /// Minimum required message length in characters.
  final int minLength;

  /// Diagnostic severity level (ERROR, WARNING, INFO, or HINT).
  final DiagnosticSeverity severity;

  /// The unique name identifier for this rule.
  static const String ruleName = 'debang_message_too_short';

  static const String _description =
      'Checks that debang messages are descriptive enough';

  @override
  LintCode get diagnosticCode => LintCode(
        ruleName,
        'Debang assertion too short.',
        uniqueName: 'debang.$ruleName',
        correctionMessage: 'Use a more descriptive message.',
        severity: severity,
      );

  @override
  void registerNodeProcessors(
      RuleVisitorRegistry registry, RuleContext context) {
    final visitor =
        _Visitor(rule: this, context: context, minLength: minLength);

    registry.addMethodInvocation(this, visitor);
    registry.addInstanceCreationExpression(this, visitor);
  }
}

/// AST visitor that checks debang message length.
class _Visitor extends SimpleAstVisitor<void> {
  _Visitor({
    required this.rule,
    required this.context,
    required this.minLength,
  });

  final DebangAssertionTooShortRule rule;
  final RuleContext context;
  final int minLength;

  @override
  void visitMethodInvocation(MethodInvocation node) {
    if (node.methodName.name != 'debang') return;

    final args = node.argumentList.arguments;
    if (args.isEmpty) return;

    _checkMessage(args.first);
  }

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final typeName = node.constructorName.type.name.lexeme;
    if (typeName != 'Debang') return;

    if (node.constructorName.name != null) return;

    final args = node.argumentList.arguments;
    if (args.isEmpty) return;

    _checkMessage(args.first);
  }

  /// Validates message length and reports error if too short.
  void _checkMessage(Expression expr) {
    if (expr is! StringLiteral) return;

    final message = expr.stringValue;
    if (message == null) return;

    if (message.length >= minLength) return;

    final unit = context.currentUnit;
    if (unit == null) return;

    final reporter = unit.diagnosticReporter;

    reporter.atNode(
      expr,
      rule.diagnosticCode,
    );
  }
}
