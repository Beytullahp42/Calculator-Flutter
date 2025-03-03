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
      title: "Kilometer to Mile Converter",
      body: body(),
      context: context,
    );
  }

  TextEditingController mileToKmController = TextEditingController();
  TextEditingController kmToMileController = TextEditingController();

  void convertKmToMile(String input) {
    double km = double.tryParse(input) ?? 0;
    double mile = km * 0.621371;
    mileToKmController.text = mile.toString();
  }

  void convertMileToKm(String input) {
    double mile = double.tryParse(input) ?? 0;
    double km = mile / 0.621371;
    kmToMileController.text = km.toString();
  }

  Column body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: kmToMileController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Kilometers",
              border: OutlineInputBorder(),
            ),
            onChanged: convertKmToMile,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: mileToKmController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Miles",
              border: OutlineInputBorder(),
            ),
            onChanged: convertMileToKm,
          ),
        ),
      ],
    );
  }
}