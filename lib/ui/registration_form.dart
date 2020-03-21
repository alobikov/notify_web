import 'package:flutter/material.dart';
import 'package:web_notify/blocs/registration/reg_populate_fields.dart';
import 'package:web_notify/blocs/registration/registration_form_bloc.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  RegistrationFormBloc _registrationFormBloc;
  bool isSignin = true;
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();
  String nameError, emailError, passwordError, confirmError;
  bool nameText = false;
  bool emailText = false;
  bool passwordText = false;
  bool confirmText = false;
  bool passwordVisible;

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
    _registrationFormBloc = RegistrationFormBloc();
    _registrationFormBloc.init();

    nameCtrl.addListener(nameFieldValidator);
    emailCtrl.addListener(emailFieldValidator);
    passwordCtrl.addListener(passwordFieldValidator);
    confirmCtrl.addListener(confirmFieldValidator);
  }

  @override
  void dispose() {
    _registrationFormBloc?.dispose();
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
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Notify'),
        centerTitle: true,
      ),
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
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
          child: Form(
            child: Column(
              children: <Widget>[
                SizedBox(height: 30),
//! Header
                Center(
                  child: Text(
                      isSignin ? 'Login to your account' : 'Create Account',
                      style: TextStyle(fontSize: 24)),
                ),
                SizedBox(height: 20.0),
//! Name field
                if (!isSignin)
                  TextField(
                    controller: nameCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'user name',
                      errorText: nameError,
                    ),
                    onChanged: null, //TODO
                    keyboardType: TextInputType.text,
                  ),
                SizedBox(height: 20.0),
//! Email field
                TextField(
                  controller: emailCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'email',
                    errorText: emailError,
                  ),
                  onChanged: null, //TODO
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20.0),
//! Password ield
                TextField(
                  controller: passwordCtrl,
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
                  obscureText: passwordVisible,
                  onChanged: null, //TODO
                ),
                SizedBox(height: 20.0),
//! Pasword Confrim field
                if (!isSignin)
                  TextField(
                    controller: confirmCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'retype password',
                      errorText: confirmError,
                    ),
                    obscureText: passwordVisible,
                    onChanged: null, //TODO
                  ),
                SizedBox(height: 20.0),
//! Raised Button
                RaisedButton(
                  elevation: 0,
                  color: Colors.redAccent,
                  child: Text(isSignin ? 'Log In' : 'Register',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400)),
                  onPressed:
                      (nameText && emailText && passwordText && confirmText)
                          ? () {
                              // launch the registration process
                              _registrationFormBloc.inFormEvent.add(SubmitEvent(
                                  name: nameCtrl.text,
                                  email: emailCtrl.text,
                                  password: passwordCtrl.text));
                            }
                          : null, // button stays disabled in view
                ),
                SizedBox(height: 4.0),
                InkWell(
                    child: Text('Forgot password?',
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline)),
                    onTap: () {
                      print('done');
                    }),
                SizedBox(height: 4.0),
                InkWell(
                    onTap: () {
                      setState(() {
                        isSignin = !isSignin;
                      });
                    },
                    child: isSignin
                        ? Text("Don't have an account? Sing up.",
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline))
                        : Text("Already have account? Login.",
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void nameFieldValidator() {
    if (nameCtrl.text.length < 3 && nameCtrl.text.length >= 1)
      setState(() {
        nameError = 'min 3 chars';
        nameText = false;
      });
    //! extra check for case when populating fields to clear form
    else if (nameCtrl.text.length != 0) {
      setState(() {
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
      } else {
        setState(() {
          emailError = null;
          emailText = true;
        });
      }
    }
  }

  void passwordFieldValidator() {
    if (passwordCtrl.text.length != 0) {
      if (passwordCtrl.text.length < 6 && passwordCtrl.text.length >= 1)
        setState(() {
          passwordError = 'min 6 chars';
          passwordText = false;
        });
      else
        setState(() {
          passwordError = null;
          passwordText = true;
        });
    }
  }

  void confirmFieldValidator() {
    if (confirmCtrl.text.length != 0) {
      if (confirmCtrl.text.length >= 1 &&
          (passwordCtrl.text != confirmCtrl.text))
        setState(() {
          confirmError = "doesn't match";
          confirmText = false;
        });
      else
        setState(() {
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
    });
  }
}
