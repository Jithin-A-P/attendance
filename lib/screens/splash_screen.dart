import 'dart:async';
import 'package:attendance/constants.dart';
import 'package:attendance/screens/home_screen.dart';
import 'package:attendance/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static const String ID = 'SplashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String email;
  String password;

  void fetchSavedLogin() async {
    final prefs = await SharedPreferences.getInstance();
    email = prefs.getString(EMAIL);
    password = prefs.getString(PASSWORD);
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    fetchSavedLogin();
    Timer(
      Duration(seconds: 3),
      () {
        if (email == null) {
          Navigator.pushReplacementNamed(
            context,
            LoginScreen.ID,
          );
        } else {
          try {
               FirebaseAuth.instance
                .signInWithEmailAndPassword(email: email, password: password);
            Navigator.pushReplacementNamed(
              context,
              HomeScreen.ID,
            );
          } catch (e) {
            print('Error sucks $e');
            Navigator.pushReplacementNamed(
              context,
              LoginScreen.ID,
            );
          }
        }
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
