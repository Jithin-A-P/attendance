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
  String loginInfo;

  Future<void> loadFromStorage() async{
    final storage = FlutterSecureStorage();
    loginInfo = await storage.read(key: key);
    print(loginInfo);
  }

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () {
        if (loginInfo == null){
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
