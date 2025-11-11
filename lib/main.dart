import 'package:a2sv_project/core/di/service_locator.dart' as di;
import 'package:flutter/material.dart';

void main() {
  di.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countries App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Placeholder(),
    );
  }
}
