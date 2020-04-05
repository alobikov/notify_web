import 'dart:async';

import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:web_notify/models/user.dart';
import 'package:web_notify/redux/actions/auth_actions.dart';
import 'package:web_notify/src/middleware/log_middleware.dart';
import 'package:web_notify/src/middleware/parse_middleware.dart';

import 'auth/auth_actions.dart';
import 'auth/auth_reducer.dart';
import 'auth/auth_state.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is SetAuthStateAction) {
    final nextAuthState = authReducer(state.authState, action);
    return state.copyWith(authState: nextAuthState);
  } else if (action is NavigateToAlertAction) {
    print(action.message);
  }
  return state;
}

@immutable
class AppState {
  final AuthState authState;

  AppState({@required this.authState});

  AppState copyWith({AuthState authState}) {
    return AppState(
      authState: authState ?? this.authState,
    );
  }
}

class Redux {
  static Store<AppState> _store;

  static Store<AppState> get store {
    if (_store == null) {
      throw Exception("store is not initialized");
    } else {
      return _store;
    }
  }

  static Future<void> init() async {
    final authStateInitial = AuthState.initial();

    _store = Store<AppState>(
      appReducer,
      middleware: [LogMiddleware(), ParseMiddleware()],
      initialState: AppState(authState: authStateInitial),
    );
    
  }
}
// ! Application level actions
class NavigateToAlertAction {
  final String message;

  NavigateToAlertAction(this.message);
}
