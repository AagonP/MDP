import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Models/report.dart';
import 'package:provider/provider.dart';
import 'package:smart_gardern_app/Screens/Report/components/api.dart';
import 'package:smart_gardern_app/Screens/Report/components/notifier.dart';
import 'package:smart_gardern_app/Screens/Report/components/saved/saved_detail.dart';

class SavedReports extends StatefulWidget {
  String name;
  String date;
  String max;
  String mean;
  String min;
  String did;
  String unt;
  String rid;
  String infor;
  SavedReports({
    Key? key,
    required this.name,
    required this.date,
    required this.max,
    required this.mean,
    required this.min,
    required this.did,
    required this.unt,
    required this.rid,
    required this.infor,
  }) : super(key: key);
  @override
  _SavedReportState createState() => _SavedReportState();
}

class _SavedReportState extends State<SavedReports> {
  @override
  Widget build(BuildContext context) {
    ReportNotifier reportNotifier = Provider.of<ReportNotifier>(context);

    _onReportDeleted(SavedReport report) {
      reportNotifier.deleteReport(report);
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
                  width: MediaQuery.of(context).size.width * 0.59,
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
                  padding: const EdgeInsets.fromLTRB(10.0, 8.0, 0.0, 8.0),
                  child: Container(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.delete),
                      iconSize: 30,
                      color: Colors.black,
                      onPressed: () => deleteReport(
                          reportNotifier, _onReportDeleted, widget.rid),
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
                    name: widget.name,
                    date: widget.date,
                    max: widget.max,
                    mean: widget.mean,
                    min: widget.min,
                    did: widget.did,
                    unt: widget.unt,
                    rid: widget.rid,
                    infor: widget.infor,
                  );
                }),
              );
            },
          ),
        )
      ],
    );
  }
}
