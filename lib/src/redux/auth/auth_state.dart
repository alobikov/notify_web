import 'package:meta/meta.dart';
import 'package:web_notify/models/user.dart';

class AuthState {
  final bool isLoading;
  final String errorMsg;
  final AuthUser authUser;

  AuthState({this.isLoading, this.authUser, this.errorMsg});

  factory AuthState.initial() => AuthState(
        isLoading: true,
        errorMsg: null,
        authUser: null,
      );

  AuthState copyWith({
    @required bool isLoading,
    @required String errorMsg,
    @required AuthUser authUser,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      errorMsg: errorMsg ?? this.errorMsg,
      authUser: authUser ?? this.authUser,
    );
  }
}
