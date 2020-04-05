import 'package:web_notify/models/user.dart';
import 'package:web_notify/redux/actions/auth_actions.dart';
import 'package:web_notify/redux/app_state.dart';

AppState appReducer(state, action) {
  final IamUser _user = IamUser(); //TODO maybe not needed here
  if (action is SigninAction) {
    // currently does nothing - all job done in middleware
    print('appReducer SigninAction for: $_user');
    return state;
  } else if (action is SignupAction) {
    _user.fromJson(action.data);
    print(_user);
    return state;
  } else if (action is ShowRegistration) {
    print('UbnAuthorized in Reducer');
    return AppStateUnAuthorized();
  } else if (action is ShowHome) {
    print('ShowHome in Reducer');
    return AppStateAuthorized(action.user);
    //
  } else if (action is LocalLoading) {
    return RegFormStateLocalLoading();
    //
  } else if (action is ShowError) {
    return RegFormStateErrorMessage(action.message);
  } else if (action is RegFormContinue) {
    return RegFormStateContinue();
  } else if (action is ComposeHome) { 
    return HomeScreenComposeState(adresatas: '');
  } else if (action is SetComposeState) {
    print('Reducer adresatas: ${action.adresatas}');
    print('Reducer state adresatas: ${state.adresatas}');
    print('Reducer action message: ${action.message}');
    // return HomeScreenComposeState(adresatas: action.adresatas ?? state.adresatas, message: action.message ?? state.message);
    return HomeScreenComposeState(adresatas: 'd', message: 'e');
  }

  print(' =========== NOT handled in appReducer $action ==========*');
  return state;
}
