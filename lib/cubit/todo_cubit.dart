import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/todo_model.dart';

class TodoCubit extends Cubit<List<Todo>> {
  TodoCubit() : super([]);

  void addTodo(String title) {
    if (title.isEmpty) {
      addError('Title cannot be empty!');
      return;
    }

    final todo = Todo(
      name: title,
      createdAt: DateTime.now(),
    );

    emit([...state, todo]);
  }

  // rather than using print to log values, use inherent method from Cubit i.e. onChange
  @override
  void onChange(Change<List<Todo>> change) {
    // value changes to state is available on "change" so then print it
    super.onChange(change);
    if (kDebugMode) {
      print('TodoCubit - $change');
    }
  }

  // rather than using print to log values, use inherent method from Cubit i.e. onError
  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    // any error that occurs due to state changes, "use error/stackTrace to print"
    if (kDebugMode) {
      print('TodoCubit - $error');
    }
  }
}
