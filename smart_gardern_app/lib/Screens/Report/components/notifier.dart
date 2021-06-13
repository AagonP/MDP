import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Models/report.dart';
import 'package:flutter/cupertino.dart';

class ReportNotifier with ChangeNotifier {
  List<Report> _reportList = [];
  List<Report> _currentList = [];
  List<SavedReport> _savedList = [];
  Report _currentReport = Report();
  String orderValue = "Newest First";
  String searchValue = "";

  // List of reports get by fetch data from firebase
  List<Report> get reportList => _reportList;
  //Current List
  List<Report> get currentList => _currentList;
  //Saved List
  List<SavedReport> get savedList => _savedList;

  Report get currentReport => _currentReport;
  String get currentorderValue => orderValue;
  String get currentsearchValue => searchValue;

  // Initialize List of report
  set reportList(List<Report> reportList) {
    _reportList = reportList;
    notifyListeners();
  }

  // Update List while using
  set currentList(List<Report> reportList) {
    _currentList = reportList;
    notifyListeners();
  }

  // Update Saved List while using
  set savedList(List<SavedReport> reportList) {
    _savedList = reportList;
    notifyListeners();
  }

  // Update order view value of List of Report
  set order(String ord) {
    orderValue = ord;
    notifyListeners();
  }

  // Update search value of List of Report
  set searching(String str) {
    searchValue = str;
    notifyListeners();
  }

  addReport(SavedReport report) {
    _savedList.insert(_savedList.length, report);
    notifyListeners();
  }

  deleteReport(SavedReport report) {
    _savedList.removeWhere((_report) => _report.rid == report.rid);
    notifyListeners();
  }
}
