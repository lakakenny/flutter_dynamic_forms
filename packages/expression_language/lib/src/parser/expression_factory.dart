import 'package:expression_language/src/expressions/expression_provider.dart';
import 'package:expression_language/src/expressions/expressions.dart';
import 'package:expression_language/src/number_type/decimal.dart';
import 'package:expression_language/src/number_type/integer.dart';
import 'package:expression_language/src/parser/expression_parser_exceptions.dart';

Expression createDelegateExpression(
    List<String> expressionPath, ExpressionProvider elementValue) {
  if (elementValue is ExpressionProvider<Integer>) {
    return DelegateExpression<Integer>(expressionPath, elementValue);
  }
  if (elementValue is ExpressionProvider<int>) {
    return IntToIntegerExpression(
      DelegateExpression<int>(expressionPath, elementValue),
    );
  }
  if (elementValue is ExpressionProvider<bool>) {
    return DelegateExpression<bool>(expressionPath, elementValue);
  }
  if (elementValue is ExpressionProvider<String>) {
    return DelegateExpression<String>(expressionPath, elementValue);
  }
  if (elementValue is ExpressionProvider<Decimal>) {
    return DelegateExpression<Decimal>(expressionPath, elementValue);
  }
  if (elementValue is ExpressionProvider<double>) {
    return DoubleToDecimalExpression(
      DelegateExpression<double>(expressionPath, elementValue),
    );
  }
  if (elementValue is ExpressionProvider<ExpressionProviderElement>) {
    return DelegateExpression<ExpressionProviderElement>(
        expressionPath, elementValue);
  }
  if (elementValue is ExpressionProvider<List<ExpressionProviderElement>>) {
    return DelegateExpression<List<ExpressionProviderElement>>(
        expressionPath, elementValue);
  }
  throw UnknownExpressionFactoryException("Unknown expression factory");
}

ConditionalExpression createConditionalExpression(
    Expression<bool> condition, Expression trueValue, Expression falseValue) {
  if (trueValue is Expression<Integer>) {
    return ConditionalExpression<Integer>(condition, trueValue, falseValue);
  }
  if (trueValue is Expression<bool>) {
    return ConditionalExpression<bool>(condition, trueValue, falseValue);
  }
  if (trueValue is Expression<String>) {
    return ConditionalExpression<String>(condition, trueValue, falseValue);
  }
  if (trueValue is Expression<Decimal>) {
    return ConditionalExpression<Decimal>(condition, trueValue, falseValue);
  }
  throw UnknownExpressionTypeException(
      "Unknown expression in conditional expression");
}

Expression createFunctionExpression(
    String functionName, List<Expression> parameters) {
  if (functionName == "length") {
    if (parameters.length != 1) {
      throw InvalidParameterCount(
          "Function $functionName expects only 1 parameter");
    }
    return LengthFunctionExpression(parameters[0]);
  }
  if (functionName == "toString") {
    if (parameters.length != 1) {
      throw InvalidParameterCount(
          "Function $functionName expects only 1 parameter");
    }
    return ToStringFunctionExpression(parameters[0]);
  }
  if (functionName == "count") {
    if (parameters.length != 1) {
      throw InvalidParameterCount(
          "Function $functionName expects only 1 parameter");
    }
    return ListCountFunctionExpression(parameters[0]);
  }
  if (functionName == "round") {
    if (parameters.length == 3) {
      if (parameters[2] is Expression<Integer>) {
        return RoundFunctionIntRoundingModeExpression(
            parameters[0], parameters[1], parameters[2]);
      } else if (parameters[2] is Expression<String>) {
        return RoundFunctionStringRoundingModeExpression(
            parameters[0], parameters[1], parameters[2]);
      } else {
        throw InvalidParameterException(
            "Function $functionName expects integer or string as third parameter");
      }
    } else if (parameters.length == 2) {
      return RoundFunctionExpression(parameters[0], parameters[1]);
    } else {
      throw InvalidParameterCount(
          "Function $functionName expects 2 or 3 parameters");
    }
  }
  if (functionName == "dateTime") {
    if (parameters.length != 1) {
      throw InvalidParameterCount(
          "Function $functionName expects only 1 parameter");
    }
    return DateTimeFunctionExpression(parameters[0]);
  }
  if (functionName == "duration") {
    if (parameters.length != 1) {
      throw InvalidParameterCount(
          "Function $functionName expects only 1 parameter");
    }
    return DurationFunctionExpression(parameters[0]);
  }
  if (functionName == "now") {
    if (parameters.isNotEmpty) {
      throw InvalidParameterCount(
          "Function $functionName does not expect any parameter");
    }
    return NowFunctionExpression();
  }
  if (functionName == "nowInUtc") {
    if (parameters.isNotEmpty) {
      throw InvalidParameterCount(
          "Function $functionName does not expect any parameter");
    }
    return NowInUtcFunctionExpression();
  }
  if (functionName == "diffDateTime") {
    if (parameters.length != 2) {
      throw InvalidParameterCount(
          "Function $functionName expects exactly 2 parameters");
    }
    return DiffDateTimeFunctionExpression(parameters[0], parameters[1]);
  }
  if (functionName == "durationInDays") {
    if (parameters.length != 1) {
      throw InvalidParameterCount(
          "Function $functionName expects only 1 parameter");
    }
    return DurationInDaysFunctionExpression(parameters[0]);
  }
  if (functionName == "durationInHours") {
    if (parameters.length != 1) {
      throw InvalidParameterCount(
          "Function $functionName expects only 1 parameter");
    }
    return DurationInHoursFunctionExpression(parameters[0]);
  }
  if (functionName == "durationInMinutes") {
    if (parameters.length != 1) {
      throw InvalidParameterCount(
          "Function $functionName expects only 1 parameter");
    }
    return DurationInMinutesFunctionExpression(parameters[0]);
  }
  if (functionName == "durationInSeconds") {
    if (parameters.length != 1) {
      throw InvalidParameterCount(
          "Function $functionName expects only 1 parameter");
    }
    return DurationInSecondsFunctionExpression(parameters[0]);
  }
  if (functionName == "matches") {
    if (parameters.length != 2) {
      throw InvalidParameterCount(
          "Function $functionName expects exactly 2 parameters");
    }
    return MatchesFunctionExpression(parameters[0], parameters[1]);
  }
  if (functionName == "contains") {
    if (parameters.length != 2) {
      throw InvalidParameterCount(
          "Function $functionName expects exactly 2 parameters");
    }
    return ContainsFunctionExpression(parameters[0], parameters[1]);
  }
  if (functionName == "startsWith") {
    if (parameters.length != 2) {
      throw InvalidParameterCount(
          "Function $functionName expects exactly 2 parameters");
    }
    return StartsWithFunctionExpression(parameters[0], parameters[1]);
  }
  if (functionName == "endsWith") {
    if (parameters.length != 2) {
      throw InvalidParameterCount(
          "Function $functionName expects exactly 2 parameters");
    }
    return EndsWithFunctionExpression(parameters[0], parameters[1]);
  }
  throw UnknownFunctionException("Unknown function name $functionName");
}
