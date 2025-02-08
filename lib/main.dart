import 'dart:math';
import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScientificCalculator(),
    );
  }
}

class ScientificCalculator extends StatefulWidget {
  @override
  _ScientificCalculatorState createState() => _ScientificCalculatorState();
}

class _ScientificCalculatorState extends State<ScientificCalculator> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';

  void _evaluateExpression() {
    try {
      final expression = Expression.parse(_controller.text);
      final evaluator = const ExpressionEvaluator();
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

  void _calculateLogarithm() {
    final number = double.tryParse(_controller.text);
    if (number != null && number > 0) {
      final result = log(number);
      setState(() {
        _result = 'Log($number): ${result.toStringAsFixed(5)}';
      });
    } else {
      setState(() {
        _result = 'Por favor, digite um número positivo válido';
      });
    }
  }

  void _calculateExponentiation() {
    final parts = _controller.text.split('^');
    if (parts.length == 2) {
      final base = double.tryParse(parts[0]);
      final exponent = double.tryParse(parts[1]);
      if (base != null && exponent != null) {
        final result = pow(base, exponent);
        setState(() {
          _result = 'Resultado: ${result.toStringAsFixed(5)}';
        });
      } else {
        setState(() {
          _result = 'Por favor, digite uma expressão válida';
        });
      }
    } else {
      setState(() {
        _result = 'Por favor, digite uma expressão no formato base^expoente';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora Científica'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Digite a expressão ou número',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _evaluateExpression,
                  child: Text('Calcular'),
                ),
                ElevatedButton(
                  onPressed: () => _calculateTrigFunction('sin'),
                  child: Text('Seno'),
                ),
                ElevatedButton(
                  onPressed: () => _calculateTrigFunction('cos'),
                  child: Text('Cosseno'),
                ),
                ElevatedButton(
                  onPressed: () => _calculateTrigFunction('tan'),
                  child: Text('Tangente'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _calculateExponentiation,
                  child: Text('Expoente'),
                ),
                ElevatedButton(
                  onPressed: _calculateLogarithm,
                  child: Text('Logaritmo'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Resultado: $_result',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
