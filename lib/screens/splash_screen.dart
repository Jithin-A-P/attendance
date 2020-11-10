import 'dart:async';
import 'package:attendance/screens/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const String ID = 'SplashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String loginInfo;

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () {
        if (loginInfo == null) {
          Navigator.pushReplacementNamed(
            context,
            LoginScreen.ID,
          );
        } else {}
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'ATTENDANCE',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 48,
            letterSpacing: 10.0,
          ),
        ),
      ),
    );
  }
}
