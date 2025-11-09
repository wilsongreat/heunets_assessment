import 'package:flutter/material.dart';
import 'package:heunets_assessment_app/app.dart';
import 'core/config/app/di_container.dart' as dicontainer;

void main() async {
  await dicontainer.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HeunetsJobApp(),
    );
  }
}

