import 'dart:async';
import '../../../constant.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:smart_gardern_app/Helpers/mqtt_helper.dart';
import 'package:smart_gardern_app/Models/device.dart';
import 'package:smart_gardern_app/mqtt.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


class HumidityRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HumidityRouteState();
  }
}

class _HumidityRouteState extends State<HumidityRoute> {
  var humd = 0.0;
  var data = "0.0-0.0";

  var lst = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
  var lstTime = ["0.0", "0.0","0.0","0.0","0.0","0.0","0.0"];
 
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
    
    var listTempHumid = Provider.of<DeviceModel>(context).devices;
    
    for (var i = 0; i < listTempHumid.length; i++) {
      if (listTempHumid[i].id == "7") {
        data = listTempHumid[i].data;
        humd = double.parse(data.split("-")[1]);
        break;
      }
      humd = 0.0;
    }
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm').format(now);
    lst.insert(0, humd);
    lstTime.insert(0, formattedDate);
    
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Humidty"),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Positioned(
              child: Image.asset(
                "assets/images/plant_bg.jpeg",
                width: size.width,
                height: size.height * 0.3,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              top: size.height * 0.25,
              child: 
                 Container(
                    child: Column(children: [
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Text('Humidity Chart', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20))
                      ),
                      AspectRatio(
                      aspectRatio: 1.7,
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        color: const Color(0xff2c4260),
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceAround,
                            maxY: 5,
                            barTouchData: BarTouchData(
                              enabled: false,
                              touchTooltipData: BarTouchTooltipData(
                                tooltipBgColor: Colors.transparent,
                                tooltipPadding: const EdgeInsets.all(0),
                                tooltipMargin: 8,
                                getTooltipItem: (
                                  BarChartGroupData group,
                                  int groupIndex,
                                  BarChartRodData rod,
                                  int rodIndex,
                                ) {
                                  return BarTooltipItem(
                                    rod.y.round().toString(),
                                    TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                            ),
                            titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: SideTitles(
                                showTitles: true,
                                getTextStyles: (value) => const TextStyle(
                                    color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
                                margin: 20,
                                getTitles: (double value) {
                  switch (value.toInt()) {
                    case 0:
                      return lstTime[6];
                    case 1:
                      return lstTime[5];
                    case 2:
                      return lstTime[4];
                    case 3:
                      return lstTime[3];
                    case 4:
                      return lstTime[2];
                    case 5:
                      return lstTime[1];
                    case 6:
                      return lstTime[0];
                    default:
                      return '';
                  }
                },
                              ),
                              leftTitles: SideTitles(showTitles: false),
                            ),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            barGroups: [
                              BarChartGroupData(
                                x: 0,
                                barRods: [
                                  BarChartRodData(y: lst[6], colors: [Colors.lightBlueAccent, Colors.greenAccent])
                                ],
                                showingTooltipIndicators: [0],
                              ),
                              BarChartGroupData(
                                x: 1,
                                barRods: [
                                  BarChartRodData(y: lst[5], colors: [Colors.lightBlueAccent, Colors.greenAccent])
                                ],
                                showingTooltipIndicators: [0],
                              ),
                              BarChartGroupData(
                                x: 2,
                                barRods: [
                                  BarChartRodData(y: lst[4], colors: [Colors.lightBlueAccent, Colors.greenAccent])
                                ],
                                showingTooltipIndicators: [0],
                              ),
                              BarChartGroupData(
                                x: 3,
                                barRods: [
                                  BarChartRodData(y: lst[3], colors: [Colors.lightBlueAccent, Colors.greenAccent])
                                ],
                                showingTooltipIndicators: [0],
                              ),
                              BarChartGroupData(
                                x: 4,
                                barRods: [
                                  BarChartRodData(y: lst[2], colors: [Colors.lightBlueAccent, Colors.greenAccent])
                                ],
                                showingTooltipIndicators: [0],
                              ),
                              BarChartGroupData(
                                x: 5,
                                barRods: [
                                  BarChartRodData(y: lst[1], colors: [Colors.lightBlueAccent, Colors.greenAccent])
                                ],
                                showingTooltipIndicators: [0],
                              ),
                              BarChartGroupData(
                                x: 6,
                                barRods: [
                                  BarChartRodData(y: lst[0], colors: [Colors.lightBlueAccent, Colors.greenAccent])
                                ],
                                showingTooltipIndicators: [0],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ), 
                    ],), 
                    padding: EdgeInsets.symmetric(
                      horizontal: kDefaultPadding, vertical: kDefaultPadding),
                    alignment: Alignment.center,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(29),
                        topRight: Radius.circular(29),
                      ),
                    ),
                  )
            )
          ],
        )
      ),
    );
  }
}
