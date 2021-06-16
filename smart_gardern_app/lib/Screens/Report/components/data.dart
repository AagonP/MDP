import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Models/report.dart';
import 'package:smart_gardern_app/Screens/Report/components/api.dart';
import 'package:smart_gardern_app/Screens/Report/components/notifier.dart';
import 'package:smart_gardern_app/Screens/Report/components/report.dart';
import 'package:provider/provider.dart';

class Data extends StatefulWidget {
  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  @override
  void initState() {
    getinitial();
    super.initState();
  }

  void getinitial() async {
    ReportNotifier reportNotifier =
        Provider.of<ReportNotifier>(context, listen: false);
    List<Report> reports = await getdevice(reportNotifier);
    getReports(reportNotifier, reports, reportNotifier.currentsearchValue,
        reportNotifier.currentorderValue);
    getsaved(reportNotifier);
  }

  @override
  Widget build(BuildContext context) {
    ReportNotifier reportNotifier = Provider.of<ReportNotifier>(context);

    Future<void> _refreshList() async {
      getdevice(reportNotifier);
    }

    if (reportNotifier.currentList.length == 0) {
      return Text(
        "Nothing available yet!",
        style: TextStyle(fontSize: 25),
      );
    }
    ScrollController _scrollController = new ScrollController();

    return Column(
      children: <Widget>[
        new RefreshIndicator(
          child: ListView.separated(
            shrinkWrap: true,
            controller: _scrollController,
            itemBuilder: (BuildContext context, int index) {
              bool flag = false;
              flag = checksavedReport(
                  reportNotifier.currentList[index].rid, reportNotifier);
              return Reports(
                  name: reportNotifier.currentList[index].name.toString(),
                  date: reportNotifier.currentList[index].date.toString(),
                  max: reportNotifier.currentList[index].max.toString(),
                  mean: reportNotifier.currentList[index].mean.toString(),
                  min: reportNotifier.currentList[index].min.toString(),
                  did: reportNotifier.currentList[index].did.toString(),
                  unt: reportNotifier.currentList[index].unt.toString(),
                  rid: reportNotifier.currentList[index].rid,
                  checker: flag);
            },
            itemCount: reportNotifier.currentList.length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: Colors.black,
              );
            },
          ),
          onRefresh: _refreshList,
        ),
      ],
    );
  }
}
