import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:smart_gardern_app/Helpers/mqtt_helper.dart';
import 'package:smart_gardern_app/Models/device.dart';
import 'package:smart_gardern_app/Screens/Device%20Control/Statistic/donut_chart.dart';
import 'package:smart_gardern_app/mqtt.dart';
import 'package:provider/provider.dart';

class SoilMoistureChart extends StatefulWidget {
  @override
  State<SoilMoistureChart> createState() {
    return _SoilMoistureChartState();
  }
}

class _SoilMoistureChartState extends State<SoilMoistureChart> {
  var data = 0.0;
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
    await mqtt.subcribe('bk-iot-soil');
  }

  @override
  Widget build(BuildContext context) {
    var listDevices = Provider.of<DeviceModel>(context).devices;
    for (var i = 0; i < listDevices.length; i++) {
      if (listDevices[i].id == "9") {
        //print(1);
        data = double.parse(listDevices[i].data.toString());
        break;
      }
      data = 0.0;
    }
    return Consumer<DeviceModel>(
      builder: (context, devicemodel, child) => CustomPaint(
        foregroundPainter: DonutProgress(data, Colors.green),
        child: Container(
          width: 200,
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Moisture'),
                Text(
                  '${data}',
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
    );
  }
}
