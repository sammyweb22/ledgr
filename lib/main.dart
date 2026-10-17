import 'package:flutter/material.dart';
import 'package:ledgr_core/ledgr_core.dart';

import 'data/sample_data.dart';
import 'screens/home_screen.dart';

void main() {
  final tracker = createSampleTracker();
  runApp(MainApp(tracker: tracker));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.tracker});

  final ExpenseTracker tracker;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ledgr',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.deepPurple),
      home: HomeScreen(tracker: tracker),
    );
  }
}
