import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Models/report.dart';
import 'package:smart_gardern_app/Screens/Home/home_screen.dart';
import 'package:smart_gardern_app/Screens/Report/components/api.dart';
import 'package:smart_gardern_app/Screens/Report/components/notifier.dart';
import 'package:smart_gardern_app/screens/Report/components/body.dart';
import 'package:provider/provider.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreen createState() => _ReportScreen();
}

class _ReportScreen extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double wid = size.width.toDouble();
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return HomeScreen();
                }),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () {
              ReportNotifier reportNotifier =
                  Provider.of<ReportNotifier>(context, listen: false);
              _onAddReport(Report report) {
                Navigator.pop(context);
                reportNotifier.addReport(report);
              }

              Map detail = {
                'wt': 12,
                'moisture': 99,
                'light': "Hard",
                'temp': 35,
                'infor': "Hello World",
              };
              Map<String, dynamic> data = {
                'name': "ReportTest",
                'device': 'BKCSEKit',
                'date': '02/06/2021',
                'detail': detail
              };
              addReport(data, _onAddReport, reportNotifier);
            },
            child: Text("Create"),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
        title: Text('Report Management'),
      ),
      body: Body(),
    );
  }
}
