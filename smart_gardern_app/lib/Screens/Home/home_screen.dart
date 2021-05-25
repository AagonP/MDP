import 'package:flutter/material.dart';

import '../../components/rounded_button.dart';
import '../Plant Library/Overview/plantlib_overview_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                child: RoundedButton(press: () {}, text: "Report management"),
              ),
              Container(
                child: RoundedButton(press: () {}, text: "Statistics"),
              ),
              Container(
                child: RoundedButton(press: () {}, text: "Control devices"),
              ),
              Container(
                child: RoundedButton(
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return Overview();
                        }),
                      );
                    },
                    text: "Plant Library"),
              ),
              Container(
                child: RoundedButton(press: () {}, text: "Chatbox"),
              ),
            ],
          ),
        ));
  }
}
