import 'package:attendance/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  static const String ID = 'LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FlutterSecureStorage storage;
  @override
  void initState() {
    storage = FlutterSecureStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FlatButton(
          child: Text('Login'),
          onPressed: () async{
            await storage.write(key: LOGIN_INFO, value: 'LOGGED_IN');
          },
        )
      ),
    );
  }
}
