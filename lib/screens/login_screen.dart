import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static String ID = 'LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Login Screen')
      ),
    );
  }
}
