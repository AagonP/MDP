import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Screens/Report/components/api.dart';
import 'package:smart_gardern_app/Screens/Report/components/notifier.dart';
import 'package:provider/provider.dart';
import 'package:smart_gardern_app/Screens/Report/components/saved/saved_report.dart';

class SavedData extends StatefulWidget {
  @override
  _SavedDataSate createState() => _SavedDataSate();
}

class _SavedDataSate extends State<SavedData> {
  @override
  void initState() {
    getinitial();
    super.initState();
  }

  void getinitial() async {
    ReportNotifier reportNotifier =
        Provider.of<ReportNotifier>(context, listen: false);
    getsaved(reportNotifier);
  }

  @override
  Widget build(BuildContext context) {
    ReportNotifier reportNotifier = Provider.of<ReportNotifier>(context);
    Future<void> _refreshList() async {
      getsaved(reportNotifier);
    }

    if (reportNotifier.savedList.length == 0) {
      return Text(
        "List of saved report is empty!",
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
              // print(reportNotifier.currentReport.);
              return SavedReports(
                name: reportNotifier.savedList[index].name.toString(),
                date: reportNotifier.savedList[index].date.toString(),
                max: reportNotifier.savedList[index].max.toString(),
                mean: reportNotifier.savedList[index].mean.toString(),
                min: reportNotifier.savedList[index].min.toString(),
                did: reportNotifier.savedList[index].did.toString(),
                unt: reportNotifier.savedList[index].unt.toString(),
                rid: reportNotifier.savedList[index].rid,
                infor: reportNotifier.savedList[index].infor,
              );
            },
            itemCount: reportNotifier.savedList.length,
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
