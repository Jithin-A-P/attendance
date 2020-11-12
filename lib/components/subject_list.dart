import 'package:attendance/components/subject_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SubjectStream extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;
  final _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final snapshots = _firestore.collection('subjects').doc(_user.uid).snapshots();
    return StreamBuilder(
      stream: snapshots,
      builder: (context, snapshot) {
        var subjectData = snapshot.data.data();
        if (subjectData == null) {
          return Center(
            child: Text(
                'Looks like you haven\'t added any subjects\nClick on \'+\' to add subjects'),
          );
        }
        final userDocument = Map<String, dynamic>.from(subjectData['subjects']);
        List<SubjectTile> subjectTiles = [];
        for (var subject in userDocument.entries) {
          final subjectTile = SubjectTile(
            title: subject.key,
            attendedClasses: subject.value['attended-class'],
            totalClasses: subject.value['total-class'],
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
        return Text(
            'Looks like you haven\'t added any subjects\nClick on \'+\' to add subjects');
      },
    );
  }
}