import 'dart:async';
import '../../../constant.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:smart_gardern_app/Helpers/mqtt_helper.dart';
import 'package:smart_gardern_app/Models/device.dart';
import 'package:smart_gardern_app/Screens/Statistics/Statistic/donut_chart.dart';
import 'package:smart_gardern_app/mqtt.dart';
import 'package:provider/provider.dart';

// class TempAndHumdChart extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _TempAndHumdChartState();
//   }
// }

// class _TempAndHumdChartState extends State<TempAndHumdChart> {
//   var temp = 0.0;
//   var humd = 0.0;
//   var data = "0.0-0.0";
//   @override
//   void initState() {
//     super.initState();
//     asyncMethod().whenComplete(() {
//       setState(() {});
//     }).catchError((error, stackTrace) {
//       print("outer: $error");
//     });
//   }

//   Future<void> asyncMethod() async {
//     var mqtt = MqttHelper();
//     mqtt.client = await mqtt.connect();
//     //Listen to changes
//     mqtt.client!.updates!.listen(
//       (List<MqttReceivedMessage<MqttMessage>> c) {
//         final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
//         final payload =
//             MqttPublishPayload.bytesToStringAsString(message.payload.message!);
//         // When receiving data, decode it and update by Provider package
//         print("===DATA--RECEIVED=============$payload");
//         var data = mqttDecode(payload);
//         Provider.of<DeviceModel>(context, listen: false).update(
//             new Device(data['id'], data['name'], data['data'], data['unit']));
//       },
//     );
//     await mqtt.subcribe('bk-iot-temp-humid');
//   }
//   @override
//   Widget build(BuildContext context) {
//     var listDevices = Provider.of<DeviceModel>(context).devices;
//     for (var i = 0; i < listDevices.length; i++) {
//       if (listDevices[i].id == "7") {
//         data = listDevices[i].data;
//         temp = double.parse(data.split("-")[0]);
//         humd = double.parse(data.split("-")[1]);
//         break;
//       }
//       temp = 0.0;
//       humd = 0.0;
//     }
//     return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
//         Widget>[
//       CustomPaint(
//         foregroundPainter: DonutProgress(temp, Colors.blue),
//         child: Container(
//           width: 200,
//           height: 200,
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text('Temperature'),
//                 Text(
//                   '${temp}',
//                   style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   '°C',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       CustomPaint(
//         foregroundPainter: DonutProgress(humd, Colors.red),
//         child: Container(
//           width: 200,
//           height: 200,
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text('Humid'),
//                 Text(
//                   '${humd}',
//                   style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   '%',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     ]);
//   }
// }


class TemperatureRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Temperature"),
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
                        child: Text('Temperature Chart', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20))
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
                            maxY: 20,
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
                                      return 'Mon';
                                    case 1:
                                      return 'Tue';
                                    case 2:
                                      return 'Wed';
                                    case 3:
                                      return 'Thu';
                                    case 4:
                                      return 'Fri';
                                    case 5:
                                      return 'Sat';
                                    case 6:
                                      return 'Sun';
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
                                  BarChartRodData(y: 8, colors: [Colors.lightBlueAccent, Colors.greenAccent])
                                ],
                                showingTooltipIndicators: [0],
                              ),
                              BarChartGroupData(
                                x: 1,
                                barRods: [
                                  BarChartRodData(y: 10, colors: [Colors.lightBlueAccent, Colors.greenAccent])
                                ],
                                showingTooltipIndicators: [0],
                              ),
                              BarChartGroupData(
                                x: 2,
                                barRods: [
                                  BarChartRodData(y: 14, colors: [Colors.lightBlueAccent, Colors.greenAccent])
                                ],
                                showingTooltipIndicators: [0],
                              ),
                              BarChartGroupData(
                                x: 3,
                                barRods: [
                                  BarChartRodData(y: 15, colors: [Colors.lightBlueAccent, Colors.greenAccent])
                                ],
                                showingTooltipIndicators: [0],
                              ),
                              BarChartGroupData(
                                x: 4,
                                barRods: [
                                  BarChartRodData(y: 13, colors: [Colors.lightBlueAccent, Colors.greenAccent])
                                ],
                                showingTooltipIndicators: [0],
                              ),
                              BarChartGroupData(
                                x: 5,
                                barRods: [
                                  BarChartRodData(y: 10, colors: [Colors.lightBlueAccent, Colors.greenAccent])
                                ],
                                showingTooltipIndicators: [0],
                              ),
                              BarChartGroupData(
                                x: 6,
                                barRods: [
                                  BarChartRodData(y: 12, colors: [Colors.lightBlueAccent, Colors.greenAccent])
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