import 'dart:math';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';

  void _evaluateExpression() {
    try {
      final expression = Expression.parse(_controller.text);
      const evaluator = ExpressionEvaluator();
      final result = evaluator.eval(expression, {});

      setState(() {
        _result = result.toString();
      });
    } catch (e) {
      setState(() {
        _result = 'Erro na expressão';
      });
    }
  }

  void _calculateTrigFunction(String function) {
    final number = double.tryParse(_controller.text);
    if (number != null) {
      double result;
      switch (function) {
        case 'sin':
          result = sin(number);
          break;
        case 'cos':
          result = cos(number);
          break;
        case 'tan':
          result = tan(number);
          break;
        default:
          result = 0.0;
      }
      setState(() {
        _result = '$function($number): ${result.toStringAsFixed(5)}';
      });
    } else {
      setState(() {
        _result = 'Por favor, digite um número válido';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculos Trigonométricos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Digite a expressão ou número',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _evaluateExpression,
                  child: const Text('Calcular'),
                ),
                ElevatedButton(
                  onPressed: () => _calculateTrigFunction('sin'),
                  child: const Text('Seno'),
                ),
                ElevatedButton(
                  onPressed: () => _calculateTrigFunction('cos'),
                  child: const Text('Cosseno'),
                ),
                ElevatedButton(
                  onPressed: () => _calculateTrigFunction('tan'),
                  child: const Text('Tangente'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Resultado: $_result',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpressionEvaluator {
  const ExpressionEvaluator();

  eval(expression, Map map) {}
}

class Expression {
  static parse(String text) {}
}
