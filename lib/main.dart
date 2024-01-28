import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/providers/cart_provider.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

// Provider : after the initial return value; it only allows the consumer widgets to read data and that's all
// ChangeNotifierProvider: when the value received and updated, consumer/listening Widgets will be notified of those changes and so those widgets will "Re-run its build method"
// FutureProvider: same as the "ChangeNotifier" it just works with Future
// StreamProvider: same as the above two and it handles Stream data

// ## Using MultiProvider

// return MultiProvider(
// providers: [ChangeNotifierProvider(), ChangeNotifierProvider()],
// child: MaterialApp()
// )

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      // return value from create method can be accessible throughout any widgets (since it wraps MaterialApp)
      child: MaterialApp(
          title: "Shopping App",
          theme: ThemeData(
            fontFamily: 'Lato',
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromRGBO(254, 206, 1, 1),
                primary: const Color.fromRGBO(254, 206, 1, 1)),
            appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(fontSize: 20, color: Colors.black),
            ),
            inputDecorationTheme: const InputDecorationTheme(
                hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                prefixIconColor: Color.fromRGBO(119, 119, 119, 1)),
            textTheme: const TextTheme(
                titleLarge:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                titleMedium:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                bodySmall:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            useMaterial3: true,
          ),
          // home: ProductDetailsPage(product: products[0]),
          home: const HomePage()),
          // home: Provider(create: (context) => "some value", child: const HomePage())),
    );
  }
}


// IntertwinedWidget: simply looks for the from its nearest ancestor, the moment it finds it then it stops and if it doesn't find then uses the initial/default value
// Provider is a wrapper around InheritedWidget


// Responsive UI: to ensure responsive UI on WEB 20:08:25