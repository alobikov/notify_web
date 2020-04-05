import 'dart:async';

import 'package:web_notify/models/user.dart';

import 'auth_state.dart';

class SetAuthStateAction {
  final AuthState authState;

  SetAuthStateAction({this.authState});
}

class SigninAction extends SetAuthStateAction {
  SigninAction({authState}) : super(authState: authState);
  SigninAction.fromJson(json) : super(authState: AuthState(authUser: AuthUser.fromJson(json)));
}

class SignupAction extends SetAuthStateAction {
  SignupAction({authState}) : super(authState: authState);
  SignupAction.fromJson(json) : super(authState: AuthState(authUser: AuthUser.fromJson(json)));
}

class SignoutAction extends SetAuthStateAction {
  SignoutAction({authState}) : super(authState: authState);
}

/// USE CASES
/// store.dispatch(SetAuthStateAction(authState: AuthState(isLoading: false, authToken: null))); // navigates to Registration
/// from old version - widget.store.dispatch(SignupAction(data));

// ! Actions for MIDDLEWARE

class Initialize {}

class Loading {
  int timeout;
  Function callback;
  Timer timer;

  Loading({this.timeout, this.callback}) {
    timer = Timer(Duration(seconds: timeout), callback);
  }
  get cancel => timer.cancel();
}
