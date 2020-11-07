import 'package:flutter/material.dart';

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
    return Container(
      height: 50.0,
      width: double.infinity,
      color: Colors.pink,
      child: Text(
        title,
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}
