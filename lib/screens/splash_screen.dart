import 'dart:async';
import 'package:attendance/screens/home_screen.dart';
import 'package:attendance/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashScreen extends StatefulWidget {
  static String ID = 'SplashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String key = "login_info";

  @override
  void initState() async {
    super.initState();

    final storage = FlutterSecureStorage();
    final String login_info = await storage.read(key: key);
    print(login_info);

    Timer(
      Duration(seconds: 3),
      () {
        if (login_info == null){
          Navigator.pushNamed(
            context,
            LoginScreen.ID,
          );
        } else {
          Navigator.pushNamed(
            context,
            HomeScreen.ID,
          );
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
