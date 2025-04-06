import '../model/calculation.dart';
import 'database_service.dart';

class CalculatorLogic {
  String _firstNumber = "";
  String _operator = "";
  String _secondNumber = "";
  String display = "";

  void handleInput(String input) {
    if (input == "C") {
      clear();
    } else if (input == "⌫") {
      backspace();
    } else if (input == "=") {
      calculateResult();
      return;
    } else if (input == "!") {
      applyFactorial();
      return;
    } else if (input == ".") {
      addDecimal();
    } else if (_isOperator(input)) {
      applyOperator(input);
      if (display == "Error") return;
    } else if (isDigit(input)) {
      appendDigit(input);
    }
    updateDisplay();
  }

  bool isDigit(String input) {
    return int.tryParse(input) != null;
  }

  bool _isOperator(String input) {
    return input == "+" ||
        input == "÷" ||
        input == "×" ||
        input == "–" ||
        input == "mod";
  }

  void appendDigit(String input) {
    if (_operator.isEmpty) {
      if ((_firstNumber == "0" || _firstNumber == "-") && input == "0") return;
      _firstNumber += input;
    } else {
      if ((_secondNumber == "0" || _secondNumber == "-") && input == "0") {
        return;
      }
      _secondNumber += input;
    }
  }

  void addDecimal() {
    if (_operator.isEmpty) {
      if (!_firstNumber.contains(".")) {
        _firstNumber += ".";
      }
    } else {
      if (!_secondNumber.contains(".")) {
        _secondNumber += ".";
      }
    }
  }

  void applyOperator(String input) {
    if (display == "Error") {
      return;
    }
    if (_firstNumber.isEmpty) {
      if (input == "–") {
        _firstNumber = "-";
      }
      return;
    }

    if (_operator.isNotEmpty && _secondNumber.isNotEmpty) {
      double result = _calculate();
      String resultString;
      if (result == result.toInt()) {
        resultString = result.toInt().toString();
      } else {
        resultString = result.toString();
      }
      saveCalculation(resultString);
      _firstNumber = resultString;
      _secondNumber = "";
    }
    _operator = input;
  }

  void calculateResult() {
    if (_firstNumber.isEmpty) return;
    double result = _calculate();
    String resultString;
    if (result == result.toInt()) {
      resultString = result.toInt().toString();
    } else {
      resultString = result.toString();
    }
    saveCalculation(resultString);
    if (display == "Error") return;
    clear();
    display = resultString;
    _firstNumber = resultString;
  }

  Future<void> saveCalculation(String result) async {
    String calculation = "$_firstNumber $_operator $_secondNumber = $result";
    Calculation newCalculation = Calculation(
      calculation: calculation,
      date: DateTime.now(),
    );

    await DatabaseService().insert(newCalculation);
  }

  double _calculate() {
    double num1 = double.parse(_firstNumber);
    if (_secondNumber.isEmpty) return num1;
    double num2 = double.parse(_secondNumber);
    switch (_operator) {
      case "+":
        return num1 + num2;
      case "–":
        return num1 - num2;
      case "×":
        return num1 * num2;
      case "÷":
        if (num2 == 0) {
          showFinalMessage("Error");
          return 0.0;
        }
        return num1 / num2;
      case "mod":
        return num1 % num2;
      default:
        return num1;
    }
  }

  void applyFactorial() {
    if (display == "Error") {
      return;
    }
    if (_secondNumber.isNotEmpty) {
      _firstNumber = _calculate().toInt().toString();
      _operator = "";
      _secondNumber = "";
    }

    if (_firstNumber.contains(".")) {
      showFinalMessage("Error");
      return;
    }
    int number = int.parse(_firstNumber);
    if (number < 0) {
      showFinalMessage("Error");
      return;
    }
    int result = 1;
    for (int i = 1; i <= number; i++) {
      result *= i;
    }
    clear();
    display = result.toString();
    _firstNumber = result.toString();
  }

  void backspace() {
    if (_secondNumber.isNotEmpty) {
      _secondNumber = _secondNumber.substring(0, _secondNumber.length - 1);
    } else if (_operator.isNotEmpty) {
      _operator = "";
    } else if (_firstNumber.isNotEmpty) {
      _firstNumber = _firstNumber.substring(0, _firstNumber.length - 1);
    }
  }

  void clear() {
    _firstNumber = "";
    _operator = "";
    _secondNumber = "";
    display = "";
  }

  void showFinalMessage(String message) {
    clear();
    display = message;
  }

  void updateDisplay() {
    if (_firstNumber.isEmpty) {
      display = "";
    } else if (_operator.isEmpty) {
      display = _firstNumber;
    } else if (_secondNumber.isEmpty) {
      display = "$_firstNumber $_operator";
    } else {
      display = "$_firstNumber $_operator $_secondNumber";
    }
  }
}
