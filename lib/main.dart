import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Everything in flutter is a "widget" i.e. class

// 1. Stateless widget: doesn't allow to update state (immutable state)

// 2. Stateful widget: state can be updated / mutated

class MyApp extends StatelessWidget {
  // const MyApp({key?: key}): super(key: key);
  const MyApp({super.key}); // shorthand for the above code

  @override
  Widget build(BuildContext context) {
    // when returning an widget (e.g. Text), use 'const'
    // return const Text("Hello, Flutter", textDirection: TextDirection.rtl);
    return const MaterialApp();
  }
}
