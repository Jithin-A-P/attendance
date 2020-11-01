import 'dart:async';
import 'package:attendance/constants.dart';
import 'package:attendance/screens/home_screen.dart';
import 'package:attendance/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashScreen extends StatefulWidget {
  static const String ID = 'SplashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String loginInfo;

  Future<void> loadFromStorage() async{
    final storage = FlutterSecureStorage();
    loginInfo = await storage.read(key: LOGIN_INFO);
    print("SplashScreen :: loginInfo :: value :: $loginInfo");
  }

  @override
  void initState() {
    super.initState();
    loadFromStorage();
    Timer(
      Duration(seconds: 3),
      () {
        if (loginInfo == null){
          Navigator.pushReplacementNamed(
            context,
            LoginScreen.ID,
          );
        } else {
          Navigator.pushReplacementNamed(
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
