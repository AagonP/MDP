import 'dart:convert';

class Report {
  String name = "";
  String device = "";
  String date = "";
  Map detail = {
    'wt': 0,
    'moisture': 0,
    'light': "",
    'temp': 0,
    'infor': "",
  };
  String rid = "";

  Report();

  Report.fromMap(data, id) {
    name = data["name"];
    device = data["device"];
    date = data["date"];
    detail = data["detail"];
    rid = id;
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'device': device,
      'date': date,
      'detail': detail,
    };
  }
}
