import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Models/report.dart';
import 'package:provider/provider.dart';
import 'package:smart_gardern_app/Screens/Report/components/api.dart';
import 'package:smart_gardern_app/Screens/Report/components/notifier.dart';
import 'package:smart_gardern_app/constant.dart';

class Reports extends StatefulWidget {
  String name;
  String date;
  String max;
  String mean;
  String min;
  String did;
  String unt;
  String rid;
  bool checker;
  Reports(
      {Key? key,
      required this.name,
      required this.date,
      required this.max,
      required this.mean,
      required this.min,
      required this.did,
      required this.unt,
      required this.rid,
      required this.checker})
      : super(key: key);
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    ReportNotifier reportNotifier = Provider.of<ReportNotifier>(context);

    _onReportAdded(SavedReport report) {
      reportNotifier.addReport(report);
    }

    Size size = MediaQuery.of(context).size;
    return Row(
      children: <Widget>[
        Card(
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          color: Colors.white,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: InkWell(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 8.0, 15.0, 8.0),
                  child: Image.asset(
                    'assets/images/plant.png',
                    width: size.width * 0.15,
                    height: size.height * 0.1,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.58,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 8.0, 15.0, 8.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Sensor: " +
                                    widget.name +
                                    "\nDevideID: " +
                                    widget.did +
                                    "\nDate: " +
                                    widget.date,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontFamily: 'Roboto'),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 8.0, 0.0, 8.0),
                  child: Container(
                    alignment: Alignment.topRight,
                    child: (widget.checker == false)
                        ? IconButton(
                            icon: Icon(Icons.add),
                            iconSize: 40,
                            color: kPrimaryColor,
                            onPressed: () {
                              addReport(reportNotifier.currentReport,
                                  _onReportAdded, widget.rid);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Add successful!')));
                              getsaved(reportNotifier);
                            })
                        : IconButton(
                            icon: Icon(Icons.add),
                            iconSize: 40,
                            color: kPrimaryColor,
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'This report already in saved list!')));
                            },
                          ),
                  ),
                ),
              ],
            ),
            onTap: () {
              showMyAlertDialog(context, widget.max, widget.mean, widget.min);
            },
          ),
        )
      ],
    );
  }

  showMyAlertDialog(BuildContext context, String max, String mean, String min) {
    Size size = MediaQuery.of(context).size;
    String pic = "";
    switch (widget.name) {
      case "LIGHT":
        pic = "assets/images/sun.png";
        break;
      case "SOIL":
        pic = "assets/images/soil.png";
        break;
      case "TEMP-HUMID":
        pic = "assets/images/temperature.png";
        break;
    }

    Dialog dialog = Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(children: <Widget>[
        Positioned(
          top: size.height * 0.2,
          child: Container(
            width: size.width * 0.8,
            height: size.height * 0.45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(29),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: size.height * 0.25 * 0.1,
                  left: size.width * 0.06,
                  right: 0,
                  child: Container(
                    child: Row(
                      children: [
                        Text(
                          "Sensor: " + widget.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.1,
                  left: size.width * 0.06,
                  right: 0,
                  child: Container(
                    child: Row(
                      children: [
                        Text(
                          "Date: " + widget.date,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.15,
                  left: size.width * 0,
                  right: 0,
                  child: Container(
                    child: DataTable(
                      columnSpacing: 10,
                      columns: [
                        DataColumn(
                            label: Text(
                          "Data",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        )),
                        DataColumn(
                            label: Image.asset(
                          pic,
                          height: size.height * 0.1,
                          width: size.width * 0.1,
                          scale: 0.5,
                        )),
                        if (widget.name == "TEMP-HUMID")
                          DataColumn(
                              label: Image.asset(
                            "assets/images/water.png",
                            height: size.height * 0.1,
                            width: size.width * 0.1,
                            scale: 0.5,
                          )),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text(
                            "MAX Value",
                            style: const TextStyle(fontSize: 15.0),
                          )),
                          DataCell(Text(
                            (widget.name == "TEMP-HUMID")
                                ? double.parse(widget.max.split("-")[0])
                                        .toStringAsFixed(1) +
                                    widget.unt.split("-")[0]
                                : widget.max +
                                    ((widget.unt != 'nan') ? widget.unt : ""),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          )),
                          if (widget.name == "TEMP-HUMID")
                            DataCell(Text(
                              double.parse(widget.max.split("-")[1])
                                      .toStringAsFixed(1) +
                                  widget.unt.split("-")[1],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            )),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(
                            "MEAN Value",
                            style: const TextStyle(fontSize: 15.0),
                          )),
                          DataCell(Text(
                            (widget.name == "TEMP-HUMID")
                                ? double.parse(widget.mean.split("-")[0])
                                        .toStringAsFixed(1) +
                                    widget.unt.split("-")[0]
                                : double.parse(widget.mean).toStringAsFixed(1) +
                                    ((widget.unt != 'nan') ? widget.unt : ""),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          )),
                          if (widget.name == "TEMP-HUMID")
                            DataCell(Text(
                              double.parse(widget.mean.split("-")[1])
                                      .toStringAsFixed(1) +
                                  widget.unt.split("-")[1],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            )),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(
                            "MIN Value",
                            style: const TextStyle(fontSize: 15.0),
                          )),
                          DataCell(Text(
                            (widget.name == "TEMP-HUMID")
                                ? widget.min.split("-")[0] +
                                    widget.unt.split("-")[0] +
                                    '-' +
                                    widget.min.split("-")[1] +
                                    widget.unt.split("-")[1]
                                : widget.min +
                                    ((widget.unt != 'nan') ? widget.unt : ""),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          )),
                          if (widget.name == "TEMP-HUMID")
                            DataCell(Text(
                              double.parse(widget.min.split("-")[1])
                                      .toStringAsFixed(1) +
                                  widget.unt.split("-")[1],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            )),
                        ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
  }
}
