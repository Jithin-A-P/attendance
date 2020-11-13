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
      child: Padding(
        padding: const EdgeInsets.only(
          left: 25.0,
          top: 15.0,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
