import 'package:redux/redux.dart';
import 'package:todo_app/redux/app_state.dart';

List<Middleware<AppState>> appMiddleware() {
  return [
    TypedMiddleware<AppState, dynamic>(_loggingMiddleware),
  ];
}

_loggingMiddleware(Store<AppState> store, action, NextDispatcher next) {
  print('Action: $action');
  next(action);
}
