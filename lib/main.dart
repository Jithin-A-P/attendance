import 'package:attendance/screens/home_screen.dart';
import 'package:attendance/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(AttendanceApp());
}

class AttendanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SplashScreen.ID,
      routes: {
        SplashScreen.ID: (context) => SplashScreen(),
        LoginScreen.ID: (context) => LoginScreen(),
        HomeScreen.ID: (context) => HomeScreen(),
      },
    );
  }
}