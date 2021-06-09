import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:smart_gardern_app/Helpers/mqtt_helper.dart';
import 'package:smart_gardern_app/Models/device.dart';
import 'package:smart_gardern_app/constant.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:smart_gardern_app/mqtt.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class ControlTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ControlTabState();
  }
}

class _ControlTabState extends State<ControlTab> {
  late bool _isStatusSwitched = false;
  late bool _isAutoSwitched = false;
  late int _currentValue = 50;
  var mqtt1 = MqttHelper();
  var mqtt2 = MqttHelper();
  var soilMoisture = 1000.0;
  @override
  void initState() {
    super.initState();
    asyncMethod().whenComplete(() {
      setState(() {});
    }).catchError((error, stackTrace) {
      print("outer: $error");
    });
  }

  @override
  void dispose() {
    if (mounted) {
      mqtt1.client!.disconnect();
      mqtt2.client!.disconnect();
    }
    super.dispose();
  }

  Future<void> asyncMethod() async {
    mqtt1.client = await mqtt1.connect();
    //Listen to changes
    mqtt1.client!.updates!.listen(
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
    await mqtt1.subcribe('bk-iot-relay');

    mqtt2.client = await mqtt2.connect();
    //Listen to changes
    mqtt2.client!.updates!.listen(
      (List<MqttReceivedMessage<MqttMessage>> c) {
        final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
        final payload =
            MqttPublishPayload.bytesToStringAsString(message.payload.message!);
        // When receiving data, decode it and update by Provider package
        print("===DATA--RECEIVED=============$payload");
        var data = mqttDecode(payload);
        Provider.of<DeviceModel>(context, listen: false).update(
            new Device(data['id'], data['name'], data['data'], data['unit']));
        print(soilMoisture);
        print("Status $_isStatusSwitched");
        print("Auto $_isAutoSwitched");
        if (_isAutoSwitched && !_isStatusSwitched) {
          if (_currentValue > double.parse(data['data'].toString())) {
            Map testData = {
              "id": "11",
              "name": "RELAY",
              "data": "1",
              "unit": ""
            };
            //Publish data to the server
            mqtt1.publish('bk-iot-relay', jsonEncode(testData));
          }
        }
      },
    );
    await mqtt2.subcribe('bk-iot-soil');
  }

  @override
  Widget build(BuildContext context) {
    var listDevices = Provider.of<DeviceModel>(context).devices;
    for (var i = 0; i < listDevices.length; i++) {
      if (listDevices[i].id == "11") {
        _isStatusSwitched = listDevices[i].data == "1" ? true : false;
      }
    }

    return Consumer<DeviceModel>(
        builder: (context, devicemodel, child) => Container(
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 32),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 8,
                          spreadRadius: 0.5,
                          offset: Offset(4, 4),
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/watering.png",
                          width: 95,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Status",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'roboto',
                                        fontSize: 18,
                                      ),
                                    ),
                                    Switch(
                                      value: _isStatusSwitched,
                                      onChanged: _isAutoSwitched
                                          ? null
                                          : (bool value) {
                                              Map testData = {
                                                "id": "11",
                                                "name": "RELAY",
                                                "data": value ? "1" : "0",
                                                "unit": ""
                                              };
                                              //Publish data to the server
                                              mqtt1.publish('bk-iot-relay',
                                                  jsonEncode(testData));

                                              setState(() {
                                                _isStatusSwitched = value;
                                                print(_isStatusSwitched);
                                              });
                                            },
                                      activeColor: Colors.white,
                                    ),
                                  ]),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Automatic mode",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'roboto',
                                        fontSize: 18,
                                      ),
                                    ),
                                    Switch(
                                      value: _isAutoSwitched,
                                      onChanged: (bool value) {
                                        setState(() {
                                          _isAutoSwitched = value;
                                          print(_isAutoSwitched);
                                        });
                                      },
                                      activeColor: Colors.white,
                                    ),
                                  ]),
                              Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Condition",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'roboto',
                                        fontSize: 18,
                                      ),
                                    ),
                                    CustomNumberPicker(
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      initialValue: 50,
                                      maxValue: 100,
                                      minValue: 0,
                                      step: 10,
                                      onValue: (value) {
                                        setState(() {
                                          _currentValue = value;
                                        });
                                      },
                                    ),
                                  ]),
                            ]),
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}
