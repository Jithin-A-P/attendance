import 'package:attendance/components/subject_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SubjectStream extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('subjects')
          .where("username", isEqualTo: user.email)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final subjects = snapshot.data.docs;
          List<SubjectTile> subjectTiles = [];
          for (var subject in subjects) {
            final subjectTitle = subject.data()['name'];
            final attendedClasses = subject.data()['attended-class'];
            final totalClasses = subject.data()['total-class'];
            final subjectTile = SubjectTile(
              title: subjectTitle,
              attendedClasses: attendedClasses,
              totalClasses: totalClasses,
            );
            subjectTiles.add(subjectTile);
          }
          if (subjectTiles.length > 0) {
            return ListView(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 20.0,
              ),
              children: subjectTiles,
            );
          }
        }
        return Center(
          child: Text(
            'Looks like you haven\'t added any subjects\nClick on \'+\' to add subjects',
          ),
        );
      },
    );
  }
}
