import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SubDetailsPopup extends StatelessWidget {
  final _padding = 8.0;
  String title = 'Untitled Subject';
  int totalClasses;
  int attendedClasses;

  SubDetailsPopup({
    this.title,
    this.attendedClasses,
    this.totalClasses,
  });

  @override
  Widget build(BuildContext context) {
    final _attendancePercent = attendedClasses / totalClasses;
    var _progressColor;
    if (_attendancePercent > 0.9) {
      _progressColor = Colors.green;
    } else if (_attendancePercent > 0.75) {
      _progressColor = Colors.yellow;
    } else {
      _progressColor = Colors.red;
    }
    return Dialog(
      elevation: 5.0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 300.0,
        width: 500.0,
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
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircularPercentIndicator(
                  radius: 120.0,
                  lineWidth: 13.0,
                  animation: true,
                  percent: _attendancePercent,
                  center: Text(
                    (_attendancePercent * 100).toStringAsFixed(1) + '%',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: _progressColor,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 20.0,
                  ),
                  child: Text(
                    'Total  :  $totalClasses\n\nAttended  :  $attendedClasses',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
