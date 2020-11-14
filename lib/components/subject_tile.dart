import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SubjectTile extends StatelessWidget {
  final String title;
  final int totalClasses;
  final int attendedClasses;

  SubjectTile({
    this.title,
    this.attendedClasses,
    this.totalClasses,
  });

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
    return Container(
      margin: EdgeInsets.all(8.0),
      height: 60.0,
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
      child: Row(
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
    );
  }
}
