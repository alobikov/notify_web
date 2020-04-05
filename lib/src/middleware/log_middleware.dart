import 'package:redux/redux.dart';
import 'package:web_notify/src/redux/store.dart';


class LogMiddleware implements MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, dynamic action, NextDispatcher next) {
    print('===MIDDLEWARE LOGGER===');
    print(action);
    next(action);
  }
}
