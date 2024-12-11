import 'package:flutter/material.dart';
import 'package:calculator_app/View/Calculator.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorView(),
    );
  }
}
