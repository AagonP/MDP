import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Models/report.dart';
import 'package:smart_gardern_app/Screens/Report/components/notifier.dart';

// class AuthNotifier with ChangeNotifier {
//   late User _user;

//   User get user => _user;

//   void setUser(User user) {
//     _user = user;
//     notifyListeners();
//   }
// }

// initializeCurrentUser(AuthNotifier authNotifier) async {
//   User? firebaseUser = await FirebaseAuth.instance.currentUser;

//   if (firebaseUser != null) {
//     print(firebaseUser);
//     authNotifier.setUser(firebaseUser);
//   }
// }

getReports(ReportNotifier reportNotifier) async {
  var user = FirebaseAuth.instance.currentUser;
  var uid;

  if (user != null) {
    uid = user.uid;
  }
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('User')
      .doc(uid.toString())
      .collection("Report")
      .get();

  List<Report> _reportList = [];

  snapshot.docs.forEach((document) {
    Report report = Report.fromMap(document.data(), document.id);
    _reportList.add(report);
  });

  reportNotifier.reportList = _reportList;
}

deleteReport(Report report, Function reportDeleted, id) async {
  var user = FirebaseAuth.instance.currentUser;
  var uid;

  if (user != null) {
    uid = user.uid;
  }

  await FirebaseFirestore.instance
      .collection('User')
      .doc(uid.toString())
      .collection("Report")
      .doc(id)
      .delete();

  reportDeleted(report);
}
