import 'package:expression_language/expression_language.dart';

class DivisionDurationExpression extends Expression<Duration> {
  final Expression<Duration> left;
  final Expression<Integer> right;

  DivisionDurationExpression(this.left, this.right);

  @override
  Duration evaluate() {
    if (right.evaluate().value == 0) {
      throw DivideByZeroException("Division by zero");
    }
    return left.evaluate() ~/ right.evaluate().value;
  }

  @override
  void accept(ExpressionVisitor visitor) {
    visitor.visitDivisionDuration(this);
  }
}
