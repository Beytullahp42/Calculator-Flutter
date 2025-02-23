class CalculatorLogic {
  String firstNumber = "";
  String secondNumber = "";
  String operator = "";
  int digit = 0;
  double firstNumberDouble = 0.0;
  double secondNumberDouble = 0.0;
  double result = 0.0;

  void onButtonPress(String character) {
    if (character == "C") {
      clear();
    }
    if (character == "⌫") {
      backspace();
    }
    if (character == "=") {
      calculate();
    }
    if (character == "!" && firstNumber.isNotEmpty) {
      result = factorial(firstNumberDouble.toInt()).toDouble();
    }
    if (character == "mod" && firstNumber.isNotEmpty) {
      operator = character;
    }
    if (firstNumber.isNotEmpty &&
        (character == "÷" ||
            character == "×" ||
            character == "–" ||
            character == "+")) {
      operator = character;
    }
    if(firstNumber.isEmpty && character == "-") {
      firstNumber = character;
    }
    if (character == ".") {

    }



  }

  int factorial(int n) {
    return 0;
  }

  void clear() {}

  void backspace() {}

  void calculate() {}
}
