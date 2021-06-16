import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_gardern_app/Models/report.dart';
import 'package:smart_gardern_app/Screens/Report/components/notifier.dart';

getReports(ReportNotifier reportNotifier, reports, str, ord) async {
  List<Report> _reportListtemp = reports;
  List<Report> _reportList = [];
  if (str == "") {
    _reportList = reportNotifier.reportList;
  } else {
    for (var i in _reportListtemp) {
      if ((i.date.contains(str)) | (i.date == str)) {
        _reportList.add(i);
      }
    }
  }

  if (ord == 'Oldest First') {
    if (_reportList.length > 1) {
      _reportList.sort((a, b) => a.date.compareTo(b.date));
    }
  } else {
    if (_reportList.length > 1) {
      _reportList.sort((a, b) => a.date.compareTo(b.date));
    }
    _reportList = _reportList.reversed.toList();
  }

  reportNotifier.currentList = _reportList;
}

deleteReport(ReportNotifier reportNotifier, Function reportDeleted, id) async {
  var user = FirebaseAuth.instance.currentUser;
  var uemail;

  if (user != null) {
    uemail = user.email;
  }
  SavedReport re = SavedReport();
  for (var i in reportNotifier.savedList) {
    if (i.rid == id) {
      re = i;
    }
  }
  String tempid = "";
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('User')
      .doc(uemail)
      .collection('savedlist')
      .get();
  snapshot.docs.forEach((document) {
    if (document["rid"] == id) {
      tempid = document.id;
    }
  });
  await FirebaseFirestore.instance
      .collection('User')
      .doc(uemail.toString())
      .collection("savedlist")
      .doc(tempid)
      .delete();

  reportDeleted(re);
}

checksavedReport(String id, ReportNotifier reportNotifier) {
  bool flag = false;
  for (var i in reportNotifier.savedList) {
    if (i.rid == id) {
      flag = true;
    }
  }
  return flag;
}

addReport(Report report, Function reportAdded, String rid) async {
  var user = FirebaseAuth.instance.currentUser;
  var uemail;

  if (user != null) {
    uemail = user.email;
  }
  Map savedrp = {
    'rid': "",
    'infor': "",
  };
  savedrp.update('rid', (value) => value + rid);
  SavedReport re = SavedReport.fromMap(report, "");
  SavedList sl = SavedList.fromMap(savedrp);
  await FirebaseFirestore.instance
      .collection('User')
      .doc(uemail.toString())
      .collection('savedlist')
      .add(sl.tomap());

  reportAdded(re);
}

updateReport(ReportNotifier reportNotifier, nText, id) async {
  var user = FirebaseAuth.instance.currentUser;
  var uemail;

  if (user != null) {
    uemail = user.email;
  }
  var temp = reportNotifier.savedList;
  for (var i in temp) {
    if (i.rid == id) {
      i.infor = nText;
    }
  }
  String tempid = "";
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('User')
      .doc(uemail)
      .collection('savedlist')
      .get();
  snapshot.docs.forEach((document) {
    if (document["rid"] == id) {
      tempid = document.id;
    }
  });

  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("User");
  collectionReference
      .doc(uemail)
      .collection('savedlist')
      .doc(tempid)
      .update({'infor': nText}).whenComplete(() async {
    print("Update Completed!");
  }).catchError((e) => print("Problem: $e"));
  reportNotifier.savedList = temp;
}

getdevice(ReportNotifier reportNotifier) async {
  var user = FirebaseAuth.instance.currentUser;
  var uemail;
  if (user != null) {
    uemail = user.email;
  }
  List<Report> _reportList = [];
  DeviceList lst = DeviceList();
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('User').get();
  snapshot.docs.forEach((document) {
    if (document.id == uemail) {
      lst = DeviceList.fromMap(document.data());
    }
  });

  for (int i = 0; i < lst.light.length; i++) {
    _reportList += await getdata(reportNotifier, lst.light[i], 'LIGHT');
  }
  for (int i = 0; i < lst.light.length; i++) {
    _reportList += await getdata(reportNotifier, lst.soil[i], 'SOIL');
  }
  for (int i = 0; i < lst.temphumid.length; i++) {
    _reportList +=
        await getdata(reportNotifier, lst.temphumid[i], 'TEMP-HUMID');
  }
  reportNotifier.reportList = _reportList;
  return _reportList;
}

getdata(ReportNotifier reportNotifier, String did, String kind) async {
  List<Report> _reportList = [];
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection(kind).get();

  snapshot.docs.forEach((element) {
    var data = element.data() as dynamic;
    Report report = Report.fromMap(data, element.id, kind);
    if (report.did == did) {
      _reportList.add(report);
    }
  });

  return _reportList;
}

getsaved(ReportNotifier reportNotifier) async {
  var user = FirebaseAuth.instance.currentUser;
  var uemail;
  if (user != null) {
    uemail = user.email;
  }
  List<SavedList> _savedList = [];
  List<SavedReport> savedReport = [];
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('User')
      .doc(uemail)
      .collection('savedlist')
      .get();
  snapshot.docs.forEach((document) {
    SavedList sl = SavedList.fromMap(document.data());
    _savedList.add(sl);
  });
  for (var i in _savedList) {
    for (var j in reportNotifier.reportList) {
      if (j.rid == i.rid) {
        SavedReport re = SavedReport.fromMap(j, i.infor);
        savedReport.add(re);
      }
    }
  }
  reportNotifier.savedList = savedReport;
}
