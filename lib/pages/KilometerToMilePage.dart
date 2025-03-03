import 'package:flutter/material.dart';

import 'Page.dart';

class KilometerToMilePage extends StatefulWidget {
  const KilometerToMilePage({super.key});

  final String title = "Kilometer to Mile Converter";

  @override
  State<KilometerToMilePage> createState() => _KilometerToMilePageState();
}

class _KilometerToMilePageState extends State<KilometerToMilePage> {
  @override
  Widget build(BuildContext context) {
    return app();
  }

  Widget app() {
    return MainPage(
        title: "Kilometer to Mile Converter", body: body(), context: context
    );
  }

  Column body() {
    return Column(
      children: [
        Text("Kilometer to Mile Converter"),
      ],
    );
  }
}
