import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Screens/Device%20Control/Statistic/statistic_tab.dart';
import 'package:smart_gardern_app/constant.dart';
import 'package:smart_gardern_app/Screens/Device Control/Control/control_tab.dart';
import 'package:smart_gardern_app/Screens/Device Control/Schedule/schedule_tab.dart';

class DeviceControl extends StatelessWidget {
  goBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
            length: 3,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: kPrimaryColor,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      goBack(context);
                    },
                  ),
                  title: Text("Control Device"),
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        icon: Icon(Icons.calendar_today),
                        text: "Schelue",
                      ),
                      Tab(
                        icon: Icon(Icons.settings),
                        text: "Control",
                      ),
                      Tab(
                        icon: Icon(Icons.leaderboard),
                        text: "Statistic",
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: <Widget>[
                    ScheduleTab(),
                    ControlTab(),
                    StatisticTab(),
                  ],
                ))));
  }
}
