import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:smart_gardern_app/Helpers/mqtt_helper.dart';
import 'package:smart_gardern_app/Models/device.dart';
import 'package:smart_gardern_app/Screens/Device%20Control/Statistic/donut_chart.dart';
import 'package:smart_gardern_app/mqtt.dart';
import 'package:provider/provider.dart';

class TempAndHumdChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TempAndHumdChartState();
  }
}

class _TempAndHumdChartState extends State<TempAndHumdChart> {
  var temp = 0.0;
  var humd = 0.0;
  var data = "0.0-0.0";
  @override
  void initState() {
    super.initState();
    asyncMethod().whenComplete(() {
      setState(() {});
    }).catchError((error, stackTrace) {
      print("outer: $error");
    });
  }

  Future<void> asyncMethod() async {
    var mqtt = MqttHelper();
    mqtt.client = await mqtt.connect();
    //Listen to changes
    mqtt.client!.updates!.listen(
      (List<MqttReceivedMessage<MqttMessage>> c) {
        final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
        final payload =
            MqttPublishPayload.bytesToStringAsString(message.payload.message!);
        // When receiving data, decode it and update by Provider package
        print("===DATA--RECEIVED=============$payload");
        var data = mqttDecode(payload);
        Provider.of<DeviceModel>(context, listen: false).update(
            new Device(data['id'], data['name'], data['data'], data['unit']));
      },
    );
    await mqtt.subcribe('bk-iot-temp-humid');
  }

  @override
  Widget build(BuildContext context) {
    var listDevices = Provider.of<DeviceModel>(context).devices;
    for (var i = 0; i < listDevices.length; i++) {
      if (listDevices[i].id == "7") {
        data = listDevices[i].data;
        temp = double.parse(data.split("-")[0]);
        humd = double.parse(data.split("-")[1]);
        break;
      }
      temp = 0.0;
      humd = 0.0;
    }
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
        Widget>[
      CustomPaint(
        foregroundPainter: DonutProgress(temp, Colors.blue),
        child: Container(
          width: 200,
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Temperature'),
                Text(
                  '${temp}',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                Text(
                  '°C',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
      CustomPaint(
        foregroundPainter: DonutProgress(humd, Colors.red),
        child: Container(
          width: 200,
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Humid'),
                Text(
                  '${humd}',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                Text(
                  '%',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
