import 'dart:async';

import 'package:web_notify/models/user.dart';

class SigninAction {
  Map<String, String> data;
  SigninAction(this.data);
}

class SignupAction {
  Map<String, String> data;
  SignupAction(this.data);
}
class SignoutAction {}

class Initialize {}

class Authorized {}

class UnAuthorized {}

/// brings IamUser() instance
class ShowHome {
  final IamUser user;
  ShowHome(this.user);
}

class ShowRegistration {}

class ShowError {
  final String message;
  ShowError(this.message);
  ShowError.clear() : message = null;
}

class Loading {
  int timeout;
  Function callback;
  Timer timer;

  Loading({this.timeout, this.callback}) {
    timer = Timer(Duration(seconds: timeout), callback);
  }
  get cancel => timer.cancel();
}

class LocalLoading {}

class RegFormContinue {}

class SetComposeAdresatas {
  final adresatas;

  SetComposeAdresatas(this.adresatas);
}


