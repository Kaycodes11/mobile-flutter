import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/todo_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_todo_page.dart';
import 'todo_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({key?: key}): super(key: key);
  const MyApp({super.key}); // shorthand for the above code

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(),
      child: MaterialApp(
        title: "Flutter Demo",
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true),
        initialRoute: "/",
        routes: {
          "/": (_) => const TodoList(),
          "/add-todo": (_) => const AddTodoPage(),
        },
      ),
    );
  }
}
