import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:smart_gardern_app/Screens/Statistics/Statistic/temperature_chart.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:smart_gardern_app/Helpers/mqtt_helper.dart';
import 'package:smart_gardern_app/Models/device.dart';
import 'package:smart_gardern_app/mqtt.dart';
import '../../../constant.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DashboardState();
  }
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss EEE d MMM').format(now);
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
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
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding),
              alignment: Alignment.center,
              child: Column(children:<Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Container(child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Statistics', style: TextStyle(fontWeight: FontWeight.w500))
                    )),
                    Container(child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(formattedDate,  style: TextStyle(fontWeight: FontWeight.w500))
                    )),
                  ],),
                  Row(
                  children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                        child: SingleChildScrollView(
                          child: Column(children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text('Temperature', style: TextStyle(color: Colors.white,  fontSize: 15, fontWeight: FontWeight.w500)),
                                ) 
                              ),
                            Row(
                              children: <Widget>[
                                Container(
                                  child: IconButton(
                                    iconSize:size.height * 0.05,
                                    icon: SvgPicture.asset('assets/icons/temperature.svg', 
                                      color: Colors.white),
                                    tooltip: 'Temperature chart',
                                    onPressed: () {
                                        
                                      },
                                  )
                                ),
                                Container(child: Text('18C', style: TextStyle(fontSize: 30, color: Colors.white)))
                              ]
                              ),
                            ClipRRect(
                              child: Image.asset("assets/images/temperature.png",
                              fit: BoxFit.fill,),
                               borderRadius: new BorderRadius.only(
                                  bottomLeft:  const  Radius.circular(16.0),
                                  bottomRight: const  Radius.circular(16.0))
                            ),
                            ]
                        )
                        ),
                              width: size.width * 0.33,
                              height: size.height* 0.2,
                              margin: EdgeInsets.symmetric(
                                  vertical: kDefaultPadding / 2,
                                  horizontal: kDefaultPadding),
                              decoration: BoxDecoration(
                                color:  Color(0xFF37975A),
                                borderRadius: BorderRadius.circular(16),
                              ),
                      ) ,
                        onTap:(){
                          Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => TemperatureRoute()),
                                        );
                        } ),
                      Container(
                        child: SingleChildScrollView(
                          child: Column(
                                children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text('Humidity', style: TextStyle(color: Colors.white,  fontSize: 15, fontWeight: FontWeight.w500)),) 
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  child: IconButton(
                                    iconSize:size.height * 0.05,
                                    icon: SvgPicture.asset('assets/icons/humidity.svg', 
                                      color: Colors.white),
                                    tooltip: 'Temperature chart',
                                    onPressed: () {
                                    },
                                  )
                                ),
                                Container(child: Text('54 %', style: TextStyle(fontSize: 30, color: Colors.white)))
                              ]
                            ),
                            ClipRRect(
                              child: Image.asset("assets/images/humidity.png",
                              fit: BoxFit.fill,),
                               borderRadius: new BorderRadius.only(
                                  bottomLeft:  const  Radius.circular(16.0),
                                  bottomRight: const  Radius.circular(16.0))
                            ),
                              ]
                              ) ,
                        ),
                              width: size.width * 0.33,
                              height: size.height* 0.2,
                              margin: EdgeInsets.symmetric(
                                  vertical: kDefaultPadding / 2,
                                  horizontal: kDefaultPadding),
                              decoration: BoxDecoration(
                                color:  Color(0xFFF2A559),
                                borderRadius: BorderRadius.circular(16),
                               ),
                      ),     
                    ]
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: SingleChildScrollView(
                          child: Column(
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text('Sun', style: TextStyle(color: Colors.white,  fontSize: 15, fontWeight: FontWeight.w500)),) 
                              ),
                              Row(
                              children: <Widget>[
                                Container(
                                  child: IconButton(
                                    iconSize:size.height * 0.05,
                                    icon: SvgPicture.asset('assets/icons/sun.svg', 
                                      color: Colors.white),
                                    tooltip: 'Sun chart',
                                    onPressed: () {
                                    },
                                  )
                                ),
                                Container(child: Text('30 %', style: TextStyle(fontSize: 30, color: Colors.white)))
                              ]
                            ),
                            ClipRRect(
                              child: Image.asset("assets/images/sun.png",
                              fit: BoxFit.fill,),
                               borderRadius: new BorderRadius.only(
                                  bottomLeft:  const  Radius.circular(16.0),
                                  bottomRight: const  Radius.circular(16.0))
                            ),
                              ]
                          ) ,
                        ),
                        
                              width: size.width * 0.33,
                              height: size.height* 0.2,
                              margin: EdgeInsets.symmetric(
                                  vertical: kDefaultPadding / 2,
                                  horizontal: kDefaultPadding),
                              decoration: BoxDecoration(
                                color:  Color(0xFFE42C63),
                                borderRadius: BorderRadius.circular(16),
                              ),
                      ),
                      Container(
                        child: SingleChildScrollView(
                          child: Column(
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text('Moisture', style: TextStyle(color: Colors.white,  fontSize: 15, fontWeight: FontWeight.w500)),) 
                              ),
                              Row(
                              children: <Widget>[
                                Container(
                                  child: IconButton(
                                    iconSize:size.height * 0.05,
                                    icon: SvgPicture.asset('assets/icons/moisturizing.svg', 
                                      color: Colors.white),
                                    tooltip: 'Moisture chart',
                                    onPressed: () {
                                    },
                                  )
                                ),
                                Container(child: Text('67%', style: TextStyle(fontSize: 30, color: Colors.white)))
                              ]
                            ),
                            ClipRRect(
                              child: Image.asset("assets/images/moisture.png",
                              fit: BoxFit.fill,),
                               borderRadius: new BorderRadius.only(
                                  bottomLeft:  const  Radius.circular(16.0),
                                  bottomRight: const  Radius.circular(16.0))
                            ),
                              ]
                          ) ,
                        ),
                        
                              width: size.width * 0.33,
                              height: size.height* 0.2,
                              margin: EdgeInsets.symmetric(
                                  vertical: kDefaultPadding / 2,
                                  horizontal: kDefaultPadding),
                              decoration: BoxDecoration(
                                color:  Color(0xFF8698F8),
                                borderRadius: BorderRadius.circular(16),
                               ),
                      ),     
                    ]
                  ),
                ],
                  ),
              ],),
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(29),
                  topRight: Radius.circular(29),
                ),
              ),
            ),
          ),
        ]
      )
    );
  }
}


