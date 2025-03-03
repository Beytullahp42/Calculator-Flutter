import 'package:calculator_bp/logic/calculator_logic.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  CalculatorLogic calculatorLogic = CalculatorLogic();

  String display = "";

  @override
  Widget build(BuildContext context) {
    return app();
  }

  Widget app() {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Column(
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
        ));
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
      child: Text(text, style: TextStyle(color: color, fontSize: 24), textAlign: TextAlign.end),
    );
  }

  List<String> buttonList = [
    "C", "!", "mod", "÷",
    "7", "8", "9", "×",
    "4", "5", "6", "–",
    "1", "2", "3", "+",
    "⌫", "0", ".", "="
  ];
}
