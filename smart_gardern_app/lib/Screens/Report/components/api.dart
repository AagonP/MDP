import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Models/report.dart';
import 'package:smart_gardern_app/Screens/Report/components/notifier.dart';

getcurrentReports(ReportNotifier reportNotifier, ord) async {
  var temp = reportNotifier.currentList;
  if (ord == 'Newest First') {
    if (temp.length > 0) {
      temp.sort((a, b) => a.date.compareTo(b.date));
    }
  } else {
    if (temp.length > 0) {
      temp.sort((a, b) => a.date.compareTo(b.date));
    }
    temp = temp.reversed.toList();
  }
  reportNotifier.reportList = temp;
}

getReports(ReportNotifier reportNotifier, str) async {
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
  int count = 0;
  for (var i in _reportList) {
    if (str == '') {
      _reportList = _reportList;
      break;
    } else if ((i.name.contains(str)) | (i.name == str)) {
      if (count == 0) {
        _reportList = [];
      }
      count = count + 1;
      _reportList.add(i);
    }
  }
  // print(_reportList);
  reportNotifier.reportList = _reportList;
}

updateReport(ReportNotifier reportNotifier, nText, id) async {
  var temp = reportNotifier.currentList;
  for (var i in temp) {
    if (i.rid == id) {
      i.detail['infor'] = nText;
    }
  }
  reportNotifier.reportList = temp;
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
