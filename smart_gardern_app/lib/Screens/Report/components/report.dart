import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Models/report.dart';
import 'package:smart_gardern_app/Screens/Report/components/reportdetail.dart';
import 'package:provider/provider.dart';
import 'package:smart_gardern_app/Screens/Report/components/api.dart';
import 'package:smart_gardern_app/Screens/Report/components/notifier.dart';

class Reports extends StatefulWidget {
  String name;
  String device;
  String date;
  var detail;
  String rid;
  Reports(
      {Key? key,
      required this.name,
      required this.device,
      required this.date,
      required this.detail,
      required this.rid})
      : super(key: key);
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    ReportNotifier reportNotifier = Provider.of<ReportNotifier>(context);

    _onReportDeleted(Report report) {
      Navigator.pop(context);
      reportNotifier.deleteReport(report);
    }

    Size size = MediaQuery.of(context).size;
    final String Rname = widget.name;
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 8.0, 15.0, 8.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Report: " +
                                  widget.name.toString() +
                                  "\nDevide: " +
                                  widget.device.toString() +
                                  "\nDate: " +
                                  widget.date.toString(),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(80.0, 8.0, 0.0, 8.0),
                  child: Container(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.delete),
                      iconSize: 30,
                      color: Colors.red,
                      onPressed: () => deleteReport(
                          reportNotifier.currentReport,
                          _onReportDeleted,
                          widget.rid),
                    ),
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return ReportDetail(
                      detail: widget.detail, na: Rname, id: widget.rid);
                }),
              );
            },
          ),
        )
      ],
    );
  }
}
