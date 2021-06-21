import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:smart_gardern_app/Helpers/mqtt_helper.dart';
import 'package:smart_gardern_app/Models/device.dart';
import 'package:smart_gardern_app/Screens/Device%20Control/Statistic/donut_chart.dart';
import 'package:smart_gardern_app/Screens/Device%20Control/Statistic/soil_moisture_chart.dart';
import 'package:smart_gardern_app/Screens/Device%20Control/Statistic/temp_and_humd.dart';
import 'package:smart_gardern_app/mqtt.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DashboardState();
  }
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[TempAndHumdChart(), SoilMoistureChart()],
          ),
        ));
  }
}
