import 'package:flutter/material.dart';
import 'package:flutter_application_1/weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // shorthand for the above code

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const WeatherScreen(),
    );
  }
}

// Widget tree: it's the tree representation of the component being built here <Root> <MyApp> <MaterialApp> <WeatherScreen>

// Element Tree: Reconciliation or diffing algo, decides the changes then sent to reflow and repaint

// Render Tree: get the changes from "Element Tree" and "ReFlow (layout calculation) and RePaint (style changes)
