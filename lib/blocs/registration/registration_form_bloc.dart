import 'dart:async';
import 'package:rxdart/rxdart.dart';

abstract class FormEvent {}

class FormToggle extends FormEvent {
  bool isSigninForm;
  FormToggle(this.isSigninForm);
}

class SubmitEvent extends FormEvent {
  String name, email, password;
  SubmitEvent({this.name, this.email, this.password});
  String toString() {
    return '$name $email $password';
  }
}

class RegistrationFormBloc {
  final BehaviorSubject<FormEvent> _formEventCtrl =
      BehaviorSubject<FormEvent>();
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
    }
  }

  void dispose() {
    _formEventCtrl.close();
  }
}
