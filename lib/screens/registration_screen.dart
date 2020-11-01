import 'package:attendance/components/rounded_button.dart';
import 'package:attendance/constants.dart';
import 'package:attendance/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String ID = 'RegistrationScreen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  FlutterSecureStorage storage;
  String email;
  String password;
  String confirmPassword;
  bool showSpinner = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void initState() {
    Firebase.initializeApp();
    storage = FlutterSecureStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                height: 150.0,
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
                controller: _passwordController,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                controller: _confirmController,
                onChanged: (value) {
                  confirmPassword = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Confirm your password',
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              RoundedButton(
                title: 'Sign Up',
                color: Colors.black87,
                onPressed: () {
                  setState(() {
                    showSpinner = true;
                  });
                  if (password == confirmPassword) {
                    try {
                      final _user =
                          FirebaseAuth.instance.createUserWithEmailAndPassword(
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
                  } else {
                    setState(() {
                      password = null;
                      confirmPassword = null;
                      showSpinner = false;
                      _passwordController.clear();
                      _confirmController.clear();
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text('Passwords doesn\'t match'),
                          duration: Duration(
                            seconds: 1,
                          ),
                        ),
                      );
                    });
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
