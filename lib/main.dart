import 'package:calculator/screens/calculator.dart';
import 'package:flutter/material.dart';

var darkTheme = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 64, 70, 77),
        brightness: Brightness.dark));

void main() {
  return runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkTheme,
      builder: (context, child) => const Calculator(),
    );
  }
}
