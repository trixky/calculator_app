import 'package:flutter/material.dart';

const placeHolder = "0";
const placeHolderOpacity = 0.4;
const errorMessage = "error";

class Display extends StatelessWidget {
  const Display(
      {super.key,
      required this.expression,
      required this.expressionResult,
      required this.expressionError,
      required this.results,
      required this.error});

  final String expression;
  final String expressionResult;
  final String expressionError;
  final String error;
  final List<String> results;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onBackground;
    final textSize = Theme.of(context).textTheme.titleLarge!.fontSize;

    return Expanded(
      child: Container(
        height: double.infinity,
        color: Theme.of(context).colorScheme.background,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                expression.isEmpty ? placeHolder : expression,
                style: TextStyle(
                  fontSize: textSize,
                  color: error.isNotEmpty
                      ? Colors.red
                      : textColor.withOpacity(
                          expression.isEmpty ? placeHolderOpacity : 1),
                ),
                maxLines: 1,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                expressionError.isEmpty
                    ? (expressionResult.isEmpty
                        ? placeHolder
                        : expressionResult)
                    : errorMessage,
                style: TextStyle(
                  fontSize: textSize,
                  color: (expressionError.isEmpty ? textColor : Colors.red)
                      .withOpacity(placeHolderOpacity),
                ),
                maxLines: 1,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            if (results.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      for (final result in results)
                        Text(
                          result,
                          style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .fontSize),
                          maxLines: 1,
                        ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
