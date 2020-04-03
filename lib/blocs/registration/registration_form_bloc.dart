import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:web_notify/redux/actions/auth_actions.dart';

abstract class FormEvent {}

class FormToggle extends FormEvent {
  bool isSigninForm;
  FormToggle(this.isSigninForm);
}

class SubmitEvent extends FormEvent {
  Map<String, String> data = {};
  bool type;
  SubmitEvent(this.data, {this.type});
  String toString() {
    return data.toString() + ' with type: $type';
  }
}

class RegistrationFormBloc {
  final store;
  final BehaviorSubject<FormEvent> _formEventCtrl =
      BehaviorSubject<FormEvent>();

  RegistrationFormBloc(this.store) {
    print('RegistrationFormBloc: ${store.hashCode}');
  }
  //
  //  Inputs
  //
  StreamSink<FormEvent> get inFormEvent => _formEventCtrl.sink;
  //
  // Stream Near End of Populate form buton event
  //
  Stream<FormEvent> get _formEvent => _formEventCtrl.stream;
  //
  // Initialization
  //
  void init() {
    print('init of Bloc invoked');
    _formEvent.listen(_mapFormEvent);
  }

  void _mapFormEvent(FormEvent event) {
    if (event is FormToggle) {
      print(
          'RegisterBloc: form toggle event received, this is ${event.isSigninForm ? 'Sign in' : 'Register'}');
    } else if (event is SubmitEvent) {
      print('RegisterBloc: Submit Form event received');
      print(event);
      // paylod is Map like {name: Aleks, email: aleksej.lobikov@gmail.com, password: qwerty} with type: true
      // where type:true means Signin and flase - Register
      // now we dispatching it to Redux in ccordsnce with type of authorization: signin or register
      event.type
          ? store.dispatch(SigninAction(event.data))
          : store.dispatch(SignupAction(event.data));
    }
  }

  void dispose() {
    _formEventCtrl.close();
  }
}
