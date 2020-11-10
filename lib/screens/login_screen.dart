import 'package:attendance/components/rounded_button.dart';
import 'package:attendance/constants.dart';
import 'package:attendance/screens/home_screen.dart';
import 'package:attendance/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String ID = 'LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  bool showSpinner = false;

  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 200.0,
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              RoundedButton(
                title: 'Log In',
                color: Colors.black87,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final _user =
                        FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    if (_user != null) {
                      Navigator.pushNamed(context, HomeScreen.ID);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    // TODO : Implement all edge cases for error catching
                    print(e);
                    setState(() {
                      showSpinner = false;
                    });
                  }
                },
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Not a user?',
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    FlatButton(
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, RegistrationScreen.ID);
                      },
                    ),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
