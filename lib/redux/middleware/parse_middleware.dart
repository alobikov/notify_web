import 'dart:async';

import 'package:redux/redux.dart';
import 'package:web_notify/models/user.dart';
import 'package:web_notify/redux/actions/auth_actions.dart';
import 'package:web_notify/services/parse_services.dart';
import '../app_state.dart';

class ParseMiddleware implements MiddlewareClass<AppState> {
  //! direct access to Parse Services should be should be possible only there
  final ParseServices _b4a = ParseServices();
  final IamUser _user = IamUser();

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    print("===MIDDLEWARE PARSE===");
    print('Parse instance ${_b4a.hashCode}');
    //
    if (action is Initialize) _initialize(store, action);
    else if (action is SigninAction) _signin(store, action);
    else if (action is SignupAction) _signup(store, action);
    else if (action is SignoutAction) _signout(store, action);
    next(action); //very important :)
  }

//! ============================= Initialize ===================================
  void _initialize(store, action) async {
    var showLoadingWithTimeout =
        Loading(timeout: 10, callback: () => store.dispatch(ShowError('TODO')));
    store.dispatch(showLoadingWithTimeout);
    await _b4a.initParse();
    var result = await _b4a.isLogged(); //TODO check filling properties for user
    showLoadingWithTimeout.cancel;
    result
        ? store.dispatch(ShowHome(_user))
        : store.dispatch(ShowRegistration());
  }

//! =============================Sign In========================================
  void _signin(store, action) async {
    // first, fill user properties into local repository - IamUser instance
    _user.fromJson(action.data);
    store.dispatch(LocalLoading());
    var result = await _b4a.login(_user);
    await Future.delayed(Duration(seconds: 1));
    if (result != null) store.dispatch(ShowError(result));
    store.dispatch(ShowHome(_user));
    await Future.delayed(Duration(seconds: 5));
    print('Sign in completed');
    store.dispatch(SetComposeAdresatas('Aleksej'));
  }

//! =============================Sign Up========================================
  void _signup(store, action) async {
    // first, fill user properties into local repository - IamUser instance
    _user.fromJson(action.data);
    store.dispatch(LocalLoading());
    var result = await _b4a.signup(_user);
    await Future.delayed(Duration(seconds: 1));
    if (result != null) store.dispatch(ShowError(result));
    store.dispatch(ShowHome(_user));
  }
//! =============================Sign Out=======================================
  void _signout(store, action) async {
    var result = await _b4a.signout(_user);
    if (result != null) {
      store.dispatch(ShowError(result));
      }
    store.dispatch(ShowRegistration());
  }
  
}
