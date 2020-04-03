import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'redux/actions/auth_actions.dart';
import 'redux/app_state.dart';
import 'redux/middleware/log_middleware.dart';
import 'redux/middleware/parse_middleware.dart';
import 'redux/reducer.dart';
import 'ui/home/home.dart';
import 'ui/loading.dart';
import 'ui/registration_form.dart';

const String CURRENT_RELEASE = '0.0.1';
const String CURRENT_BUILD = 'Flutter for Web';

void main() {
  final store = Store<AppState>(appReducer,
      initialState: AppStateLoading(),
      middleware: [LogMiddleware(), ParseMiddleware()]);
  print('Main ${store.hashCode}');
  runApp(MyApp(store));
}

class MyApp extends StatelessWidget {
  final store;

  const MyApp(this.store);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      child: MyMaterialApp(store),
      store: store,
    );
  }
}

class MyMaterialApp extends StatelessWidget {
  final Widget child;
  final store;
  const MyMaterialApp(this.store, {Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    store.dispatch(Initialize());
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        ignoreChange: (state) => state is LocalViewChangeState,
        builder: (BuildContext context, state) {
          return MaterialApp(
            home: Scaffold(
              body: _buildVisible(state),
            ),
          );
        });
  }

  Widget _buildVisible(AppState state) {
    if (state is AppStateLoading)
      return LoadingView();
    else if (state is AppStateAuthorized)
      return Home(state.user);
    else if (state is AppStateUnAuthorized)
      // return Home1();
      // return Home(IamUser()); //todo HomeScreen testing
      return RegistrationForm(store: store);

    throw ArgumentError('Main/_buidVisible(): No view for state: $state');
  }
}
