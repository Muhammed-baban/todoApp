import 'package:todo_app/models/todo.dart';
import 'package:todo_app/redux/actions.dart';
import 'package:todo_app/redux/app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is AddTodoAction) {
    return state.copyWith(
      todos: List.from(state.todos)..add(action.todo),
    );
  }

  if (action is ToggleTodoAction) {
    return state.copyWith(
      todos: state.todos.map((todo) {
        if (todo.id == action.id) {
          return Todo(
            id: todo.id,
            title: todo.title,
            completed: !todo.completed,
          );
        }
        return todo;
      }).toList(),
    );
  }

  if (action is DeleteTodoAction) {
    return state.copyWith(
      todos: state.todos.where((todo) => todo.id != action.id).toList(),
    );
  }

  return state;
}
