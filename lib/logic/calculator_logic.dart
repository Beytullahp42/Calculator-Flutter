import 'dart:math';

import '../model/calculation.dart';
import 'database_service.dart';

class CalculatorLogic {
  List<String> inputList = [];
  String display = '';
  String tempCalculation = '';

  Future<void> saveCalculation(String result) async {
    String calculation = "$tempCalculation = $result";
    Calculation newCalculation = Calculation(
      calculation: calculation,
      result: result,
      date: DateTime.now(),
    );

    await DatabaseService().insert(newCalculation);
  }

  void handleInput(String input) {
    if (input == 'C') {
      inputList.clear();
    } else if (input == '=') {
      _calculateResult();
      return;
    } else if (input == '⌫') {
      _handleBackspace();
    } else if (input == '%') {
      if (inputList.isNotEmpty && !_isOperator(inputList.last)) {
        double lastNumber = double.parse(inputList.last);
        double percentage = lastNumber / 100;
        inputList[inputList.length - 1] = percentage.toString();
      }
    } else if (input == '.') {
      _handleDot();
    } else if (_isOperator(input)) {
      _handleOperator(input);
    } else {
      _handleDigits(input);
    }
    updateDisplay();
  }

  void _handleDigits(String input) {
    if (inputList.isNotEmpty && !_isOperator(inputList.last)) {
      String last = inputList.last;
      if (last == '0') {
        inputList[inputList.length - 1] = input;
      } else {
        inputList[inputList.length - 1] += input;
      }
    } else if (inputList.isEmpty || _isOperator(inputList.last)) {
      inputList.add(input);
    }
  }

  void _calculateResult() {
    if (inputList.isEmpty) return;
    if (_isOperator(inputList.last)) inputList.removeLast();

    tempCalculation = inputList.join(' ');

    _evaluateOperators(['^']);
    _evaluateOperators(['×', '÷']);
    _evaluateOperators(['+', '–']);

    if (inputList.length == 1) {
      double result = double.parse(inputList[0]);
      String fixed = result.toStringAsFixed(6);
      double fixedResult = double.parse(fixed);
      if (fixedResult == fixedResult.toInt()) {
        inputList[0] = fixedResult.toInt().toString();
      } else {
        inputList[0] = fixedResult.toString();
      }
      display = inputList[0];
      saveCalculation(inputList[0]);
    }
    else {
      display = "Error";
      inputList.clear();
    }
  }

  void _evaluateOperators(List<String> operators) {
    int i = 0;
    while (i < inputList.length) {
      if (operators.contains(inputList[i])) {
        String operator = inputList[i];
        double first = double.parse(inputList[i - 1]);
        double second = double.parse(inputList[i + 1]);

        String result = _calculate(first, second, operator);
        if (result == "Error") {
          inputList.clear();
          display = "Error";
          return;
        }
        inputList[i - 1] = result;
        inputList.removeAt(i + 1);
        inputList.removeAt(i);
        i = 0;
      } else {
        i++;
      }
    }
  }

  String _calculate(double firstNumber, double secondNumber, String operator) {
    switch (operator) {
      case '+':
        return (firstNumber + secondNumber).toString();
      case '–':
        return (firstNumber - secondNumber).toString();
      case '×':
        return (firstNumber * secondNumber).toString();
      case '÷':
        if (secondNumber == 0) {
          return 'Error';
        } else {
          return (firstNumber / secondNumber).toString();
        }
      case '^':
        return pow(firstNumber, secondNumber).toString();
      default:
        return 'Error';
    }
  }

  void _handleBackspace() {
    if (inputList.isNotEmpty) {
      String lastInput = inputList.last;
      if (lastInput.length > 1) {
        inputList[inputList.length - 1] =
            lastInput.substring(0, lastInput.length - 1);
      } else {
        inputList.removeLast();
      }
    }
  }

  void _handleDot() {
    if (inputList.isNotEmpty && !_isOperator(inputList.last)) {
      String lastInput = inputList.last;
      if (!lastInput.contains('.')) {
        inputList[inputList.length - 1] = '$lastInput.';
      }
    } else {
      inputList.add('0.');
    }
  }

  bool _isOperator(String input) {
    return input == '÷' ||
        input == '×' ||
        input == '–' ||
        input == '+' ||
        input == '^';
  }

  void _handleOperator(String operator) {
    if (inputList.isNotEmpty && !_isOperator(inputList.last)) {
      inputList.add(operator);
    } else if (inputList.isNotEmpty) {
      inputList[inputList.length - 1] = operator;
    }
  }

  void updateDisplay() {
    display = inputList.join(' ');
  }
}
