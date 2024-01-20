import 'package:calculator/widgets/buttons.dart';
import 'package:calculator/widgets/display.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart' as math;

final math.Parser expressionParser = math.Parser();
final expressionContext = math.ContextModel();

const maxFloatDecimal = 20;
const maxExpressionLength = 200;

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String expression = "";
  String expressionResult = "";
  String expressionError = "";
  String error = "";
  final List<String> results = [];

  String _evaluate(String expression) {
    String result = "";

    math.Expression parsedExpression =
        expressionParser.parse(expression.replaceAll("x", "*"));
    final expresionParsed =
        parsedExpression.evaluate(math.EvaluationType.REAL, expressionContext);

    if (expresionParsed == expresionParsed.toInt().toDouble()) {
      result = (expresionParsed as double).toInt().toString();
    } else {
      final expresionParsedSplitted = expresionParsed.toString().split('.');
      var decimal = expresionParsedSplitted[1];
      if (!decimal.contains("e") && decimal.length > maxFloatDecimal) {
        decimal = "${decimal.substring(0, maxFloatDecimal)}...";
      }
      result = '${expresionParsedSplitted[0]}.$decimal';
    }

    return result;
  }

  void updateExpression(String Function(String expression) updateFunction) {
    final newExpression = updateFunction(expression);

    if (newExpression.length < maxExpressionLength) {
      if (newExpression.isNotEmpty) {
        try {
          final evaluatedExpression = _evaluate(newExpression);

          setState(() {
            expression = newExpression;
            expressionResult = evaluatedExpression;
            expressionError = "";
            error = "";
          });
        } catch (e) {
          setState(() {
            expression = newExpression;
            expressionError = e.toString();
          });
          // ignore: avoid_print
          print(error);
        }
      }
    }
  }

  void evaluateExpression() {
    if (expression.isNotEmpty) {
      try {
        final evaluatedExpression = _evaluate(expression);

        setState(() {
          results.insert(0, evaluatedExpression);
          expression = "";
          expressionResult = "";
          expressionError = "";
          error = "";
        });
      } catch (e) {
        setState(() {
          error = e.toString();
        });
        // ignore: avoid_print
        print(error);
      }
    }
  }

  void clearExpression() {
    setState(() {
      error = "";
      expressionResult = "";
      expressionError = "";
      expression = "";
    });
  }

  void clearAll() {
    setState(() {
      error = "";
      expressionResult = "";
      expressionError = "";
      expression = "";
      results.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(36.0),
        child: AppBar(
          title: const Text("Calcultator"),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          foregroundColor: Theme.of(context).textTheme.bodyMedium!.color,
        ),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: Column(
          children: [
            Display(
              expression: expression,
              expressionResult: expressionResult,
              expressionError: expressionError,
              results: results,
              error: error,
            ),
            Buttons(
              updateExpression: updateExpression,
              clearExpression: clearExpression,
              clearAll: clearAll,
              evaluateExpression: evaluateExpression,
            ),
          ],
        ),
      ),
    );
  }
}
