import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Models/report.dart';
import 'package:flutter/cupertino.dart';

class ReportNotifier with ChangeNotifier {
  List<Report> _reportList = [];

  Report _currentReport = Report();

  String orderValue = "Newest First";

  String searchValue = "";

  UnmodifiableListView<Report> get reportList =>
      UnmodifiableListView(_reportList);

  // List<Report> get currentList => _reportList;

  Report get currentReport => _currentReport;

  String get currentorderValue => orderValue;
  String get currentsearchValue => searchValue;

  set reportList(List<Report> reportList) {
    _reportList = reportList;
    notifyListeners();
  }

  set order(String ord) {
    orderValue = ord;
    notifyListeners();
  }

  set searching(String str) {
    searchValue = str;
    notifyListeners();
  }

  addReport(Report report) {
    _reportList.insert(reportList.length, report);
    orderValue = "Newest First";
    searchValue = "";
    notifyListeners();
  }

  deleteReport(Report report) {
    _reportList.removeWhere((_report) => _report.rid == report.rid);
    orderValue = "Newest First";
    searchValue = "";
    notifyListeners();
  }
}
