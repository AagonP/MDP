import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Screens/statistics/Statistic/statistic_tab.dart';
import 'package:smart_gardern_app/constant.dart';


class StatisticsScreen extends StatelessWidget {
  goBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
                appBar: AppBar(
                  backgroundColor: kPrimaryColor,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      goBack(context);
                    },
                  ),
                  title: Text("Statistics"),
                ),
                body: Center(child: StatisticTab())));
  }
}
