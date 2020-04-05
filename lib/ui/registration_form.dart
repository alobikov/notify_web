import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:web_notify/blocs/registration/reg_populate_fields.dart';
import 'package:web_notify/extensions/hover_extensions.dart';
import 'package:web_notify/src/redux/auth/auth_actions.dart';
import 'package:web_notify/src/redux/auth/auth_state.dart';
import 'package:web_notify/src/redux/store.dart';

class RegistrationForm extends StatefulWidget {
  // final store;

  // RegistrationForm({Key key, @required this.store}) : super(key: key);
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  // RegistrationFormBloc _registrationFormBloc;
  bool isSignin = true;
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();
  String nameError, emailError, passwordError, confirmError;
  bool nameText = true;
  bool emailText = true;
  bool passwordText = true;
  bool confirmText = true;
  bool passwordVisible;

  @override
  void initState() {
    super.initState();
    passwordVisible = false;

    nameCtrl.addListener(nameFieldValidator);
    emailCtrl.addListener(emailFieldValidator);
    passwordCtrl.addListener(passwordFieldValidator);
    confirmCtrl.addListener(confirmFieldValidator);
  }

  @override
  void dispose() {
    // _registrationFormBloc?.dispose();
    nameCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('!!! Register Form built !!!');
    return Scaffold(
      backgroundColor: Colors.grey[100],
      // appBar: AppBar(
      //   elevation: 0.0,
      //   title: Text('Notify'),
      //   centerTitle: true,
      // ),
      floatingActionButton: Transform.scale(
        scale: 0.7,
        child: FloatingActionButton(
          backgroundColor: Colors.grey,
          elevation: 0,
          child: Icon(Icons.refresh),
          onPressed: populateForm,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            width: 500,
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
            child: Form(
              child: StoreConnector<AppState, AuthState>(
                  converter: (store) => store.state.authState,
                  builder: (context, authState) {
                    //! ***********************************
                    return Column(
                      children: <Widget>[
                        SizedBox(height: 30),
                        Center(
                          child:
                              Image.asset('assets/bohnekamp.png', width: 150),
                        ),
                        SizedBox(height: 20),
//! Header
                        Center(
                          child: Text(
                              isSignin ? 'Sign in' : 'Create your Account',
                              style: TextStyle(fontSize: 24)),
                        ),
                        SizedBox(height: 20.0),
//! Name field
                        if (!isSignin)
                          GestureDetector(
                            child: Container(
                              height: 90.0,
                              child: TextField(
                                controller: nameCtrl,
                                onTap: _dispatchRegFormContinue,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'user name',
                                  errorText: nameError,
                                ),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ).showCursorOnHover,
//! Email field
                        GestureDetector(
                          child: Container(
                            height: 90.0,
                            child: TextField(
                              controller: emailCtrl,
                              onTap: _dispatchRegFormContinue,
                              decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(),
                                border: OutlineInputBorder(),
                                labelText: 'email',
                                errorText: emailError,
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ).showCursorOnHover,
//! Password field
                        GestureDetector(
                          child: Container(
                            height: 90,
                            child: TextField(
                              controller: passwordCtrl,
                              onTap: _dispatchRegFormContinue,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'password',
                                errorText: passwordError,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    passwordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: () {
                                    // Update the state i.e. toogle the state of passwordVisible variable
                                    setState(() {
                                      passwordVisible = !passwordVisible;
                                    });
                                  },
                                ),
                              ),
                              obscureText: !passwordVisible,
                            ),
                          ),
                        ).showCursorOnHover,
//! Pasword Confrim field
                        if (!isSignin)
                          GestureDetector(
                            child: Container(
                              height: 90,
                              child: TextField(
                                controller: confirmCtrl,
                                onTap: _dispatchRegFormContinue,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'retype password',
                                  errorText: confirmError,
                                ),
                                obscureText: passwordVisible,
                              ),
                            ),
                          ).showCursorOnHover,
//! Error Message or Linear Progress Indicator
                        _loadingOrErrorIndicator(authState),

                        SizedBox(height: 5.0),
//! Raised Button
                        Container(
                          width: 500,
                          height: 50,
                          child: RaisedButton(
                            elevation: 0,
                            color:
                                isSignin ? Colors.blueAccent : Colors.redAccent,
                            child: Text(isSignin ? 'Sign in' : 'Register',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400)),
                            onPressed: (nameText &&
                                    emailText &&
                                    passwordText &&
                                    confirmText)
                                ? () {
                                    // launch the registration process
                                    var json = {
                                      'username': nameCtrl.text,
                                      'email': emailCtrl.text,
                                      'password': passwordCtrl.text
                                    };
                                    isSignin
                                        ? Redux.store
                                            .dispatch(SigninAction.fromJson(json))
                                        : Redux.store
                                            .dispatch(SignupAction.fromJson(json));
                                  }
                                : null, // button stays disabled in view
                          ),
                        ),
                        SizedBox(height: 9.0),
                        //! Hyperlink Text fields
                        isSignin ? adviceOnSignin() : adviceOnSignup()

                        // ],
                        // ),
                      ],
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }

  Widget adviceOnSignup() {
    return GestureDetector(
      child: InkWell(
        onTap: () {
          setState(() {
            isSignin = !isSignin;
            Redux.store.dispatch(
                SetAuthStateAction()); // TODO chnage app state just to clear error message
          });
        },
        child: Text(
          "Have an account? Login.",
          style: TextStyle(color: Colors.blue),
        ),
      ),
    ).showCursorOnHover;
  }

  Widget adviceOnSignin() {
    return Row(
      children: <Widget>[
        GestureDetector(
          child: InkWell(
              child: Text(
                'Reset password?',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {
                print('done');
              }),
        ).showCursorOnHover,
        Spacer(),
        GestureDetector(
          child: InkWell(
            onTap: () {
              setState(() {
                isSignin = !isSignin;
                Redux.store.dispatch(
                    SetAuthStateAction()); // chnage app state just to clear error message
              });
            },
            child: Text(
              "Create Account",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ).showCursorOnHover,
      ],
    );
  }

  void nameFieldValidator() {
    if (nameCtrl.text.length < 3 && nameCtrl.text.length >= 1) {
      setState(() {
        nameError = 'min 3 chars';
        nameText = false;
      });
      //! extra check for case when populating fields to clear form
    } else {
      setState(() {
        print('Name validator true');
        nameError = null;
        nameText = true;
        print('nametext set to true: ${nameCtrl.text}');
      });
    }
  }

  void emailFieldValidator() {
    if (emailCtrl.text.length != 0) {
      if (!emailCtrl.text.contains(
          RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$"))) {
        setState(() {
          emailError = 'not valid email';
          emailText = false;
        });
      } else
        setState(() {
          print('Email validator true');
          emailError = null;
          emailText = true;
        });
    }
  }

  void passwordFieldValidator() {
    if (passwordCtrl.text.length != 0) {
      if (passwordCtrl.text.length < 6 && passwordCtrl.text.length >= 1) {
        setState(() {
          print('Password validator false');
          passwordError = 'min 6 chars';
          passwordText = false;
        });
      } else
        setState(() {
          print('Password validator true');
          passwordError = null;
          passwordText = true;
        });
    }
  }

  void confirmFieldValidator() {
    if (confirmCtrl.text.length != 0) {
      if (confirmCtrl.text.length >= 1 &&
          (passwordCtrl.text != confirmCtrl.text)) {
        setState(() {
          confirmError = "doesn't match";
          confirmText = false;
        });
      } else
        setState(() {
          print('Confirm validator true');
          confirmError = null;
          confirmText = true;
        });
    }
  }

  void populateForm() {
    var form = RegPopulateFields.next();
    setState(() {
      // on populate clear validation flags
      nameText = false;
      emailText = false;
      passwordText = false;
      confirmText = false;
      // populate TextFields
      nameCtrl.text = form.name;
      emailCtrl.text = form.email;
      passwordCtrl.text = form.password;
      confirmCtrl.text = form.confirmPassword;
      _dispatchRegFormContinue();
    });
  }

  /// chanage app state just to clear error message
  void _dispatchRegFormContinue() {
    var store = Redux.store;
    if (store.state.authState.errorMsg != null)
      store.dispatch(SetAuthStateAction(authState: AuthState(errorMsg: null)));
  }

  Widget _loadingOrErrorIndicator(AuthState state) {
    if (state.isLoading)
      return Container(
          alignment: Alignment.center,
          height: 20.0,
          child: LinearProgressIndicator());
    else if (state.errorMsg != null)
      return Container(
          alignment: Alignment.topCenter,
          height: 20.0,
          child: Text(state.errorMsg, style: TextStyle(color: Colors.red)));
    else
      return Container(height: 20.0);
  }
}

class TestField extends StatelessWidget {
  const TestField(this.text, {Key key}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    print('%%%%%%%%%%%% TestField rebuilt %%%%%%%%%%%%');
    return Center(
      child: Text(text),
    );
  }
}
