import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/counter_bloc.dart';
import 'package:flutter_application_1/cubit/counter_cubit.dart';
import 'package:flutter_application_1/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // shorthand for the above code

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // return value must be a bloc (not the normal class)
        BlocProvider(create: (_) => CounterCubit()),
        BlocProvider(create: (_) => CounterBloc()),
      ],
      child: MaterialApp(
        title: "Flutter demo with Bloc",
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true),
        home: const MyHomePage(title: "Flutter demo: Home Page"),
      ),
    );
  }
}

// flutter run -d chrome --web-port 55062 (to debug on browser = chrome)
// flutter run -d web-server --web-port=55062 --web-hostname=0.0.0.0 --browser-name=chrome --dart-define=FLUTTER_WEB_USE_SKIA=true --web-renderer=html
