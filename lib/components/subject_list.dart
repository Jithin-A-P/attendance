import 'package:attendance/components/subject_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SubjectStream extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('subjects').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final subjects = snapshot.data.docs;
          List<SubjectTile> subjectTiles = [];
          for (var subject in subjects) {
            final subjectTitle = subject.data()['name'];
            final attendedClasses = subject.data()['attended-class'];
            final totalClasses = subject.data()['total-class'];
            final messageBubble = SubjectTile(
              title: subjectTitle,
              attendedClasses: attendedClasses,
              totalClasses: totalClasses,
            );
            subjectTiles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 20.0,
              ),
              children: subjectTiles,
            ),
          );
        }
        return null;
      },
    );
  }
}
