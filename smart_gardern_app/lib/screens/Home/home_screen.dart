import 'package:flutter/material.dart';
import 'package:smart_gardern_app/components/rounded_button.dart';

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
                child: RoundedButton(press: () {}, text: "Plant Library"),
              ),
              Container(
                child: RoundedButton(press: () {}, text: "Chatbox"),
              ),
            ],
          ),
        ));
  }
}
