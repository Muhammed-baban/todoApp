import 'package:todo_app/models/todo.dart';

class AddTodoAction {
  final Todo todo;

  AddTodoAction(this.todo);
}

class ToggleTodoAction {
  final String id;

  ToggleTodoAction(this.id);
}

class DeleteTodoAction {
  final String id;

  DeleteTodoAction(this.id);
}
