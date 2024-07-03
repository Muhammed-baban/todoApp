import 'package:redux/redux.dart';
import 'package:todo_app/redux/app_state.dart';
import 'package:todo_app/redux/reducers.dart';
import 'package:todo_app/redux/middleware.dart';

Store<AppState> createStore() {
  return Store<AppState>(
    appReducer,
    initialState: AppState(),
    middleware: appMiddleware(),
  );
}
