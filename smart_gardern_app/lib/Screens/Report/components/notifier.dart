import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Models/report.dart';
import 'package:flutter/cupertino.dart';

class ReportNotifier with ChangeNotifier {
  List<Report> _reportList = [];
  Report _currentReport = Report();

  UnmodifiableListView<Report> get reportList =>
      UnmodifiableListView(_reportList);

  Report get currentReport => _currentReport;

  List<Report> get currentList => _reportList;

  set reportList(List<Report> reportList) {
    _reportList = reportList;
    notifyListeners();
  }

  addReport(Report report) {
    _reportList.insert(0, report);
    notifyListeners();
  }

  deleteReport(Report report) {
    _reportList.removeWhere((_report) => _report.rid == report.rid);
    notifyListeners();
  }
}
