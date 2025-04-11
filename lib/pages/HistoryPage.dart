import 'package:calculator_bp/logic/database_service.dart';
import 'package:calculator_bp/model/calculation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

import 'Page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return app();
  }

  final DatabaseService databaseService = DatabaseService();
  late Future<List<Calculation>> historyList;

  @override
  void initState() {
    super.initState();
    historyList = databaseService.getCalculations();
  }

  Widget app() {
    return Scaffold(
      appBar: null,
      body: MainPage(
        title: "History",
        body: body(),
        context: context,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await databaseService.deleteAll();
          setState(() {
            historyList = databaseService.getCalculations();
          });
        },
        backgroundColor: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
    );
  }

  Column body() {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
              future: historyList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Error loading history"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("History is empty"));
                } else {
                  List<Calculation> calculations = snapshot.data!;
                  return ListView.builder(
                    itemCount: calculations.length,
                    itemBuilder: (context, index) {
                      Calculation calculation = calculations[index];
                      return Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Clipboard.setData(
                                ClipboardData(text: calculation.result),
                              );
                              Fluttertoast.showToast(msg: "Copied to clipboard");
                            },
                            title: Text(
                              calculation.calculation,
                              style: const TextStyle(fontSize: 20),
                            ),
                            subtitle: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                DateFormat('dd/MM/yyyy HH:mm')
                                    .format(calculation.date),
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          const Divider(), // This adds the separator line
                        ],
                      );
                    },
                  );
                }
              }),
        )
      ],
    );
  }
}
