import 'package:attendance/components/rounded_button.dart';
import 'package:attendance/components/rounded_button_small.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SubjectTile extends StatefulWidget {
  final String title;
  final int totalClasses;
  final int attendedClasses;

  SubjectTile({
    this.title,
    this.attendedClasses,
    this.totalClasses,
  });

  @override
  _SubjectTileState createState() => _SubjectTileState(
        title: this.title,
        attendedClasses: this.attendedClasses,
        totalClasses: this.totalClasses,
      );
}

class _SubjectTileState extends State<SubjectTile> {
  final String title;
  int totalClasses;
  int attendedClasses;
  final _firestore = FirebaseFirestore.instance;
  final _user = FirebaseAuth.instance.currentUser;
  double _animatedHeight = 60.0;
  double _innerAnimatedHeight = 0.0;

  _SubjectTileState({
    this.title,
    this.attendedClasses,
    this.totalClasses,
  });

  void addSubject(bool present) {
    if (present) attendedClasses += 1;
    totalClasses += 1;
    try {
      _firestore.collection('subjects').doc(_user.uid).set(
        {
          'subjects': {
            title: {
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
    final _attendancePercent = (attendedClasses / totalClasses);
    var _progressColor;
    if (_attendancePercent > 0.9) {
      _progressColor = Colors.green;
    } else if (_attendancePercent > 0.75) {
      _progressColor = Colors.yellow;
    } else {
      _progressColor = Colors.red;
    }
    return GestureDetector(
      onTap: () => setState(() {
        if (_animatedHeight != 60.0) {
          _animatedHeight = 60.0;
          _innerAnimatedHeight = 0.0;
        } else {
          _animatedHeight = 175.0;
          _innerAnimatedHeight = 110.0;
        }
      }),
      child: AnimatedContainer(
        margin: EdgeInsets.all(8.0),
        height: _animatedHeight,
        duration: const Duration(milliseconds: 80),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4.0,
              spreadRadius: 4.0,
              offset: Offset(
                4.0,
                2.0,
              ),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 15.0,
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: CircularPercentIndicator(
                    radius: 45.0,
                    lineWidth: 4.0,
                    percent: _attendancePercent,
                    center: Text(
                      (_attendancePercent * 100).toStringAsFixed(1) + '%',
                      style: TextStyle(fontSize: 10),
                    ),
                    progressColor: _progressColor,
                  ),
                ),
              ],
            ),
            AnimatedContainer(
              padding: EdgeInsets.only(bottom: 8.0),
              duration: const Duration(milliseconds: 80),
              height: _innerAnimatedHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 8.0,
                    ),
                    child: Container(
                      color: Colors.black87,
                      height: 1.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Add a session :',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SmallRoundedButton(
                          title: 'Absent',
                          onPressed: () {
                            addSubject(false);
                          },
                          color: Colors.red,
                        ),
                        SmallRoundedButton(
                          title: 'Present',
                          color: Colors.green,
                          onPressed: () {
                            addSubject(true);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
