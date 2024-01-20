enum SpecialButton {
  nothing,
  evaluate,
  clearExpression,
  clearResults,
  clearAll,
}

class Button {
  const Button(this.label, this.effect, this.special);

  final String label;
  final String Function(String) effect;
  final SpecialButton special;
}
