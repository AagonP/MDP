import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Models/device.dart';
import 'package:smart_gardern_app/constant.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 32),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      setState(() {
                                        _isStatusSwitched = value;
                                        print(_isStatusSwitched);
                                      });
                                    },
                              activeColor: Colors.white,
                            ),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              initialValue: 50,
                              maxValue: 100,
                              minValue: 0,
                              step: 10,
                              onValue: (value) {
                                setState(() {
                                  _currentValue = value;
                                  print(_currentValue);
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
    );
  }
}
