import 'package:flutter/material.dart';

import 'CalculatorPage.dart';
import 'KilometerToMilePage.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
    required this.title,
    required this.body,
    required this.context,
  });

  final String title;
  final Widget body;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Text(title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
              ),
              ListTile(
                title: Text("Home"),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CalculatorPage()));
                },
              ),
              ListTile(
                  title: Text("Kilometer to Mile Converter"),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const KilometerToMilePage()),
                    );
                  }),
            ],
          ),
        ),
        body: body);
  }
}
