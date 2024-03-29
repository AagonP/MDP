import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Models/device.dart';
import 'package:smart_gardern_app/components/text_field_container.dart';
import '../../components/rounded_button.dart';
import '../../constant.dart';

import 'components/display_box.dart';
import '../../Helpers/mqtt_helper.dart';
import '../../mqtt.dart';
import 'package:mqtt_client/mqtt_client.dart';

import 'package:provider/provider.dart';

class Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var client;
    var mqtt1 = MqttHelper();
    var mqtt2 = MqttHelper();
    final valueController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding),
              child: Row(
                children: <Widget>[
                  // DisplayBox(),
                ],
              ),
            ),
            RoundedButton(
              press: () async {
                // Something really fishy here between the flow of MQTT listener and Provider listener
                // Need to rebuild this function
                // Subcribe to a test feed

                mqtt1.client = await mqtt1.connect();

                //Listen to changes
                mqtt1.client!.updates!.listen(
                  (List<MqttReceivedMessage<MqttMessage>> c) {
                    final MqttPublishMessage message =
                        c[0].payload as MqttPublishMessage;
                    final payload = MqttPublishPayload.bytesToStringAsString(
                        message.payload.message!);
                    // When receiving data, decode it and update by Provider package
                    print("===DATA--RECEIVED=============$payload");
                    var data = mqttDecode(payload);
                    Provider.of<Device>(context, listen: false).update(
                        data['id'], data['name'], data['data'], data['unit']);
                  },
                );
                mqtt2.client = await mqtt2.connect();
                mqtt2.client!.updates!.listen(
                  (List<MqttReceivedMessage<MqttMessage>> c) {
                    final MqttPublishMessage message =
                        c[0].payload as MqttPublishMessage;
                    final payload = MqttPublishPayload.bytesToStringAsString(
                        message.payload.message!);
                    // When receiving data, decode it and update by Provider package
                    print("===DATA--RECEIVED=============$payload");
                    var data = mqttDecode(payload);
                    Provider.of<Device>(context, listen: false).update(
                        data['id'], data['name'], data['data'], data['unit']);
                  },
                );
              },
              text: "Establish connection",
            ),
            RoundedButton(
              press: () async {
                // Subcribe to a test feed
                await mqtt1.subcribe('bk-iot-temp-humid');
                await mqtt2.subcribe('bk-iot-soil');
              },
              text: "Subcribe to Test feed",
            ),
            ValueInput(
              controller: valueController,
            ),
            RoundedButton(
              press: () {
                Map testData = {
                  "id": "9",
                  "name": "SOIL",
                  "data": valueController.text,
                  "unit": "%"
                };
                //Publish data to the server
                mqtt1.publish('bk-iot-temp-humid', mqttEncode(testData));
              },
              text: "Publish to Test feed",
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
            ),
            DisplayBox(),
          ],
        ),
      ),
    );
  }
}

class ValueInput extends StatefulWidget {
  final controller;
  const ValueInput({
    Key? key,
    this.controller,
  }) : super(key: key);

  @override
  _ValueInputState createState() => _ValueInputState();
}

class _ValueInputState extends State<ValueInput> {
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Input value here",
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
