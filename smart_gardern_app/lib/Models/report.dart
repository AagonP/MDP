import 'dart:convert';

class Report {
  String name = "";
  String date = "";
  String max = "";
  String mean = "";
  String min = "";
  String did = "";
  String unt = "";
  String rid = "";

  Report();

  Report.fromMap(data, id, kind) {
    name = data["name"];
    date = data["date"];
    if (kind == "TEMP-HUMID") {
      max = data['max_temp'] + '-' + data['max_humid'];
      mean = data["mean_temp"] + '-' + data['mean_humid'];
      min = data['min_temp'] + '-' + data['min_humid'];
    } else {
      max = data["max"];
      mean = data["mean"];
      min = data["min"];
    }

    unt = data["unit"];
    did = data["id"];
    rid = id;
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date,
      'max': max,
      'mean': mean,
      'min': min,
      'unit': unt,
      'id': did,
    };
  }
}

class DeviceList {
  List light = [];
  List soil = [];
  List temphumid = [];
  DeviceList();
  DeviceList.fromMap(data) {
    light = data['light'];
    soil = data['soil'];
    temphumid = data['temp-humid'];
  }
}

class SavedReport {
  String name = "";
  String date = "";
  String max = "";
  String mean = "";
  String min = "";
  String did = "";
  String unt = "";
  String rid = "";
  String infor = "";
  String sid = "";

  SavedReport();

  SavedReport.fromMap(Report report, msg) {
    name = report.name;
    date = report.date;
    // if (kind == "TEMP-HUMID") {
    //   max = data['max_temp'] + '-' + data['max_humid'];
    //   mean = data["mean_temp"] + '-' + data['mean_humid'];
    //   min = data['min_temp'] + '-' + data['min_humid'];
    // } else {
    max = report.max;
    mean = report.mean;
    min = report.min;
    // }

    unt = report.unt;
    did = report.did;
    rid = report.rid;
    infor = msg;
  }
}

class SavedList {
  String rid = "";
  String infor = "";
  // Map<String, dynamic> saved = {
  //   "rid": "",
  //   "infor": "",
  // };
  List savedlist = [];
  SavedList();
  SavedList.fromMap(data) {
    // savedlist = data["savedlist"];
    rid = data["rid"];
    infor = data["infor"];
  }
  Map<String, dynamic> tomap() {
    return {
      'rid': rid,
      'infor': infor,
    };
  }
}
// Light 13
// Soil 9
// Temp-Humid 7
