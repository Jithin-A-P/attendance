import 'package:attendance/components/add_subject_popup.dart';
import 'package:attendance/components/subject_list.dart';
import 'package:attendance/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const List<String> choices = <String>[
  "Logout",
];

class HomeScreen extends StatefulWidget {
  static const String ID = 'HomeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var user = FirebaseAuth.instance.currentUser;
  var firestoreInstance = FirebaseFirestore.instance;

  void _select(String choice) {
    if (choice == choices[0]) {
      Navigator.pushReplacementNamed(context, LoginScreen.ID);
      FirebaseAuth.instance.signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Attendance'),
        elevation: 2.0,
        actions: <Widget>[
          PopupMenuButton(
            onSelected: _select,
            padding: EdgeInsets.zero,
            // initialValue: choices[_selection],
            itemBuilder: (BuildContext context) {
              return choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      body: SubjectStream(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => AddSubPopup(),
          );
        },
      ),
    );
  }
}
