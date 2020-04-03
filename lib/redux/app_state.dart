import 'package:web_notify/models/user.dart';

// enum UiState { loading, authform, unauthorized }

// class ApState {
//   UiState uiState;

//   ApState.loading() {
//     this.uiState = UiState.loading;
//   }

//   ApState.unauthorized() {
//     this.uiState = UiState.authform;
//   }

//   String toString() {
//     return 'This is AppState instance';
//   }
// }

abstract class AppState {
}

// LocalVireChangeState stops build by StoreConnector in MyMaterialApp
class LocalViewChangeState {}

class AppStateLoading implements AppState {}

class AppStateAuthorized implements AppState {
  final IamUser user;
  AppStateAuthorized(this.user);
}

class AppStateInitialize implements AppState {}

class AppStateUnAuthorized implements AppState {}

class RegFormStateErrorMessage with LocalViewChangeState implements AppState {
  final String errorMessage;
  RegFormStateErrorMessage(this.errorMessage);
}

class RegFormStateLocalLoading with LocalViewChangeState implements AppState {}

class RegFormStateContinue with LocalViewChangeState implements AppState {}

// ! Home screen states

class HomeScreenComposeState with LocalViewChangeState implements AppState {
  final String adresatas;
  HomeScreenComposeState(this.adresatas);
}
