import 'package:attendance/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddSubPopup extends StatelessWidget {
  final _user = FirebaseAuth.instance.currentUser;
  final _firestore = FirebaseFirestore.instance;

  void addSubject(String subject, int totalClasses, int attendedClasses) {
    try {
      _firestore.collection('subjects').doc(_user.uid).set(
        {
          'subjects': {
            subject: {
              'total-class': totalClasses,
              'attended-class': attendedClasses,
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
    int _totalClasses = 0;
    int _attendedClasses = 0;
    return Dialog(
      elevation: 5.0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 340.0,
        padding: EdgeInsets.all(_padding),
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
                decoration: popupInputDecor.copyWith(hintText: 'Name'),
                onChanged: (value) {
                  _subName = value;
                  print(_totalClasses);
                },
              ),
            ),
            Text(
              'Classes so far :',
              style: TextStyle(fontSize: 16.0),
            ),
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: popupInputDecor.copyWith(hintText: 'Total'),
                      onChanged: (value) {
                        _totalClasses = int.parse(value);
                      },
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration:
                            popupInputDecor.copyWith(hintText: 'Attended'),
                        onChanged: (value) {
                          _attendedClasses = int.parse(value);
                        }),
                  ),
                ),
              ],
            ),
            RaisedButton(
              onPressed: () {
                addSubject(_subName, _totalClasses, _attendedClasses);
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
