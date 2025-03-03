import 'package:flutter/material.dart';

import '../logic/calculator_logic.dart';
import 'Page.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  CalculatorLogic calculatorLogic = CalculatorLogic();

  String display = "";

  @override
  Widget build(BuildContext context) {
    return app();
  }

  Widget app() {
    return MainPage(title: "Calculator", body: calculatorPageBody(), context: context);
  }

  Column calculatorPageBody() {
    return Column(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(right: 16, bottom: 8, left: 16),
            child: Text(
              display,
              style: TextStyle(fontSize: 48),
            ),
          ),
        ),
        Divider(
          height: 1,
          color: Colors.green,
          thickness: 1,
        ),
        Container(
          padding: EdgeInsets.only(right: 8),
          child: buttons(),
        ),
      ],
    );
  }

  Widget buttons() {
    return GridView.count(
      crossAxisCount: 4,
      childAspectRatio: 1.25,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(buttonList.length, (index) {
        return calculatorButtons(buttonList[index]);
      }),
    );
  }

  Widget calculatorButtons(String text) {
    Color color = Colors.black;
    Color backgroundColor = Colors.transparent;
    if (text == "=") {
      color = Colors.white;
      backgroundColor = Colors.green;
    } else if (text == "C" ||
        text == "!" ||
        text == "mod" ||
        text == "÷" ||
        text == "×" ||
        text == "–" ||
        text == "+" ||
        text == "⌫") {
      color = Colors.green;
    }
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
      ),
      onPressed: () {
        calculatorLogic.handleInput(text);
        setState(() {
          display = calculatorLogic.display;
        });
      },
      child: Text(text,
          style: TextStyle(color: color, fontSize: 24),
          textAlign: TextAlign.end),
    );
  }

  List<String> buttonList = [
    "C",
    "!",
    "mod",
    "÷",
    "7",
    "8",
    "9",
    "×",
    "4",
    "5",
    "6",
    "–",
    "1",
    "2",
    "3",
    "+",
    "⌫",
    "0",
    ".",
    "="
  ];
}


