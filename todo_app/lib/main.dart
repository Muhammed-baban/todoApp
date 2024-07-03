import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/redux/app_state.dart';
import 'package:todo_app/redux/store.dart';
import 'package:todo_app/redux/actions.dart';

void main() {
  final store = createStore();
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({required this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Todo App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TodoListPage(),
      ),
    );
  }
}

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Add a todo',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    final String text = _controller.text;
                    if (text.isNotEmpty) {
                      final todo = Todo(
                        id: DateTime.now().toString(),
                        title: text,
                        completed: false,
                      );
                      StoreProvider.of<AppState>(context).dispatch(AddTodoAction(todo));
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: StoreConnector<AppState, List<Todo>>(
              converter: (store) => store.state.todos,
              builder: (context, todos) {
                return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return ListTile(
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          decoration: todo.completed ? TextDecoration.lineThrough : TextDecoration.none,
                          color: todo.completed ? Colors.grey : Colors.black,
                        ),
                      ),
                      leading: Checkbox(
                        value: todo.completed,
                        onChanged: (_) {
                          StoreProvider.of<AppState>(context).dispatch(ToggleTodoAction(todo.id));
                        },
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          StoreProvider.of<AppState>(context).dispatch(DeleteTodoAction(todo.id));
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
