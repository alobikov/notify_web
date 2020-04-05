import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:web_notify/src/redux/store.dart';
import 'redux/actions/auth_actions.dart';
import 'src/redux/auth/auth_actions.dart';
import 'src/redux/auth/auth_state.dart';
import 'ui/home/home.dart';
import 'debug/home1.dart';
import 'ui/loading.dart';
import 'ui/registration_form.dart';

const String CURRENT_RELEASE = '0.0.1';
const String CURRENT_BUILD = 'Flutter for Web';

void main() async {
  print('Main()');
  await Redux.init();
  print('ready to launch MyApp');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notify',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StoreProvider<AppState>(
        child: HomePage(),
        store: Redux.store,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Redux.store.dispatch(Initialize()); // action for MIDDLEWARE
    return Scaffold(
      body: StoreConnector<AppState, AuthState>(
        distinct: true,
        converter: (store) => store.state.authState,
        builder: (BuildContext context, state) {
          return _buildVisible(state);
        },
      ),
    );
  }

  Widget _buildVisible(AuthState state) {
    if (state.isLoading) {
      return LoadingView();
    } else if (state.authUser == null) {
      return RegistrationForm();
    } else if (state.authUser != null) {
      return Home1();
    }
    throw ArgumentError('Main/_buidVisible(): No view for Auth state change');
  }
}
