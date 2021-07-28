import 'dart:math';

import 'package:mqtt_client/mqtt_client.dart';
import 'dart:async';
import 'package:mqtt_client/mqtt_server_client.dart';

const host = 'io.adafruit.com';
const port = 1883;
// const adafruit_user = 'pmhieu58';
// const key = 'aio_TyFS72TlW1Yh6JLDiTtQITZxX1Nz';
// const defaultFeedPath = 'pmhieu58/feeds/';

const adafruit_user = 'CSE_BBC';
const key = 'aio_YqQF29yXm1YVckRjWSB8zrwF229R';
const defaultFeedPath = 'CSE_BBC/feeds/';
class MqttHelper {
  MqttServerClient? client;
  Future<void> publish(String topic, String value) async {
    if (client == null) {
      await connect();
    }
    final builder = MqttClientPayloadBuilder();
    builder.addString(value);
    client!.publishMessage(
        defaultFeedPath + topic, MqttQos.atLeastOnce, builder.payload!);
  }

  Future<void> subcribe(String topic) async {
    if (client == null) {
      await connect();
    }
    client!.subscribe(defaultFeedPath + topic, MqttQos.atLeastOnce);
  }

// connection succeeded
  static void onConnected() {
    print('Connected');
  }

// unconnected
  static void onDisconnected() {
    print('Disconnected');
  }

// subscribe to topic succeeded
  static void onSubscribed(String topic) {
    print('Subscribed topic: $topic');
  }

// subscribe to topic failed
  static void onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
  }

// unsubscribe succeeded
  static void onUnsubscribed(String? topic) {
    print('Unsubscribed topic: $topic');
  }

// PING response received
  void pong() {
    print('Ping response client callback invoked');
  }

  Future<MqttServerClient?> connect() async {
    client = MqttServerClient.withPort(host, '', port);
    client!.logging(on: true);
    client!.onConnected = onConnected;
    client!.onDisconnected = onDisconnected;
    client!.onUnsubscribed = onUnsubscribed;
    client!.onSubscribed = onSubscribed;
    client!.onSubscribeFail = onSubscribeFail;
    client!.pongCallback = pong;

    final connMessage = MqttConnectMessage()
        .authenticateAs(adafruit_user, key)
        .keepAliveFor(60)
        .withWillTopic('willtopic') // More ref
        .withWillMessage('Will message')
        .startClean() // More ref
        .withWillQos(MqttQos.atLeastOnce);
    client!.connectionMessage = connMessage;

    try {
      await client!.connect();
    } catch (e) {
      print('Exception: $e');
      client!.disconnect();
    }

    // // Listen to the broker
    // client!.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
    //   final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
    //   final payload =
    //       MqttPublishPayload.bytesToStringAsString(message.payload.message!);
    //   // Remove this when done testing
    //   print("===DATA--RECEIVED=============$payload");
    //   var data = mqttDecode(payload);
    // });
    return client;
  }
}
