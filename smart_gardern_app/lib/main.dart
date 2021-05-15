import 'package:flutter/material.dart';
import 'constant.dart';
import 'screens/Welcome/welcome_screen.dart';
import 'dart:math';
import 'mqtt.dart';
import 'dart:async';

//firebase libs
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Testing MQTT package
void initTest() async {
  // Connect to Adafruit server
  await MqttHelper.connect();
  // Subcribe to a test feed
  await MqttHelper.subcribe('test/json');
  // var rng = new Random();
  // for (int i = 0; i < 10; i++) {
  //   MqttHelper.publish('moisture-sensor', rng.nextInt(100).toString());
  // }
  // Format of the data to upload
  Map data = {"id": "1", "name": "LED", "data": "X", "unit": ""};
  // Publish data to the server
  MqttHelper.publish('test/json', data.toString());
}

void main() {
  // Remove this when done testing
  // initTest();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          // return SomethingWentWrong();
          return Container();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container();
      },
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //Don't display banner when debugging
      title: 'Smart Farm',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(),
    );
  }
}
