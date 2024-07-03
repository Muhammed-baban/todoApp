import 'package:todo_app/models/todo.dart';

class AppState {
  final List<Todo> todos;

  AppState({this.todos = const []});

  AppState copyWith({List<Todo>? todos}) {
    return AppState(
      todos: todos ?? this.todos,
    );
  }
}
