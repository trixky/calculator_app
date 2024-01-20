import 'package:calculator/models/button.dart';
import 'package:flutter/material.dart';

var buttons = [
  Button("7", (exp) => "${exp}7", SpecialButton.nothing),
  Button("8", (exp) => "${exp}8", SpecialButton.nothing),
  Button("9", (exp) => "${exp}9", SpecialButton.nothing),
  Button("C", (exp) => "", SpecialButton.clearExpression),
  Button("<-", (exp) => exp.isEmpty ? exp : exp.substring(0, exp.length - 1),
      SpecialButton.nothing),
  Button("4", (exp) => "${exp}4", SpecialButton.nothing),
  Button("5", (exp) => "${exp}5", SpecialButton.nothing),
  Button("6", (exp) => "${exp}6", SpecialButton.nothing),
  Button("+", (exp) => "$exp+", SpecialButton.nothing),
  Button("-", (exp) => "$exp-", SpecialButton.nothing),
  Button("1", (exp) => "${exp}1", SpecialButton.nothing),
  Button("2", (exp) => "${exp}2", SpecialButton.nothing),
  Button("3", (exp) => "${exp}3", SpecialButton.nothing),
  Button("x", (exp) => "${exp}x", SpecialButton.nothing),
  Button("/", (exp) => "$exp/", SpecialButton.nothing),
  Button("0", (exp) => "${exp}0", SpecialButton.nothing),
  Button(".", (exp) => "$exp.", SpecialButton.nothing),
  Button("00", (exp) => "${exp}00", SpecialButton.nothing),
  Button("AC", (exp) => "", SpecialButton.clearAll),
  Button("=", (exp) => "", SpecialButton.evaluate),
];

void debugButton(String label) {
  // ignore: avoid_print
  print('button pressed : $label');
}

const globalMargin = 4.0;
const globalMarginHalf = globalMargin / 2;
const buttonRatioMultiplicator = 2;

class Buttons extends StatelessWidget {
  const Buttons(
      {super.key,
      required this.updateExpression,
      required this.clearExpression,
      required this.clearAll,
      required this.evaluateExpression});

  final void Function(String Function(String expression) updateFunction)
      updateExpression;
  final void Function() clearExpression;
  final void Function() clearAll;
  final void Function() evaluateExpression;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    var buttonRatio = 1.0;
    if (screenWidth > screenHeight) {
      buttonRatio = (screenWidth / screenHeight) * buttonRatioMultiplicator;
    }

    return Container(
      height: (screenWidth * (4 / 5) / buttonRatio - globalMarginHalf),
      margin: const EdgeInsets.all(globalMarginHalf),
      width: double.infinity,
      child: GridView.builder(
        primary: false,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            childAspectRatio: buttonRatio),
        itemCount: buttons.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            switch (buttons[index].special) {
              case SpecialButton.evaluate:
                evaluateExpression();
                break;
              case SpecialButton.clearExpression:
                clearExpression();
                break;
              case SpecialButton.clearAll:
                clearAll();
                break;
              default:
                updateExpression(buttons[index].effect);
            }
            debugButton(buttons[index].label);
          },
          child: Container(
            margin: const EdgeInsets.all(globalMargin),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(2),
            color: Theme.of(context).colorScheme.background.withOpacity(0.5),
            child: Text(
              buttons[index].label,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
          ),
        ),
      ),
    );
  }
}
