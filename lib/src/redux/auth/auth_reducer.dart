import 'package:web_notify/src/redux/auth/auth_state.dart';

import 'auth_actions.dart';

authReducer(AuthState prevState, SetAuthStateAction action) {
  final payload = action.authState;
  return prevState.copyWith(
    isLoading: payload.isLoading,
    authUser: payload.authUser,
    errorMsg: payload.errorMsg,
  );
}
