import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddSubPopup extends StatelessWidget {
  final _user = FirebaseAuth.instance.currentUser;
  final _firestore = FirebaseFirestore.instance;

  void addSubject(String subject) {
    try {
      _firestore.collection('subjects').doc(_user.uid).set(
        {
          'subjects': {
            subject: {
              'total-class': 0,
              'attended-class': 0,
            }
          }
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _padding = 16.0;
    String _subName = 'Subject';
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_padding),
      ),
      elevation: 5.0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 250.0,
        padding: EdgeInsets.only(
          top: _padding,
          bottom: _padding,
          left: _padding,
          right: _padding,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(_padding),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(10.0, 10.0),
            ),
          ],
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.only(top: _padding),
              child: Text(
                'Add Subject',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(_padding),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Name',
                  hintStyle: TextStyle(
                    fontSize: 18.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(24.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(24.0)),
                  ),
                ),
                onChanged: (value) {
                  _subName = value;
                },
              ),
            ),
            RaisedButton(
              onPressed: () {
                addSubject(_subName);
                Navigator.pop(context);
              },
              child: Icon(Icons.add, color: Colors.white),
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.blue),
              ),
            )
          ],
        ),
      ),
    );
  }
}
