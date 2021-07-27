import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_gardern_app/Screens/Statistics/Statistic/temperature_chart.dart';
import 'package:smart_gardern_app/Screens/Statistics/Statistic/soil_moisture_chart.dart';
import 'package:smart_gardern_app/Screens/Statistics/Statistic/humidity_chart.dart';
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
  var mois = 0.0;
  var temp = 0.0;
  var humd = 0.0;
  var data = "0.0-0.0";
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
        var mois = mqttDecode(payload);
        Provider.of<DeviceModel>(context, listen: false).update(
            new Device(mois['id'], mois['name'], mois['data'], mois['unit']));
        var data = mqttDecode(payload);
        Provider.of<DeviceModel>(context, listen: false).update(
            new Device(data['id'], data['name'], data['data'], data['unit']));
      },
    );
    await mqtt.subcribe('bk-iot-soil');
    await mqtt.subcribe('bk-iot-temp-humid');
  }
  @override

  Widget build(BuildContext context) {
    var listDevices = Provider.of<DeviceModel>(context).devices;
    for (var i = 0; i < listDevices.length; i++) {
      if (listDevices[i].id == "9") {
        //print(1);
        mois = double.parse(listDevices[i].data.toString());
        break;
      }
      mois = 0.0;
    }
    var listTempHumid = Provider.of<DeviceModel>(context).devices;
    for (var i = 0; i < listTempHumid.length; i++) {
      if (listTempHumid[i].id == "7") {
        data = listTempHumid[i].data;
        temp = double.parse(data.split("-")[0]);
        humd = double.parse(data.split("-")[1]);
        break;
      }
      temp = 0.0;
      humd = 0.0;
    }
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
                                      color: Colors.white,
                                    ),
                                    tooltip: 'Temperature chart',
                                    onPressed: () {
                                        
                                      },
                                  )
                                ),
                                Container(child: Text('${temp.toInt()}°C', style: TextStyle(fontSize: 30, color: Colors.white)))
                              ]
                              ),
                            ClipRRect(
                              child: Image.asset("assets/images/temperature1.png",
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
                                          MaterialPageRoute(builder: (context) => TemperatureRoute()),);
                        } ),
                      GestureDetector(
                        child: Container(
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
                                Container(child: Text('${humd.toInt()} %', style: TextStyle(fontSize: 30, color: Colors.white)))
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
                          onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context) => HumidityRoute()),);
                          }
                        ),   
                    ]
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child:Container(
                        child: SingleChildScrollView(
                          child: Column(
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text('Light', style: TextStyle(color: Colors.white,  fontSize: 15, fontWeight: FontWeight.w500)),) 
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
                                Container(child: Text('551', style: TextStyle(fontSize: 30, color: Colors.white)))
                              ]
                            ),
                            ClipRRect(
                              child: Image.asset("assets/images/light.png",
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
                      ) ,
                        onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context) => MoistureRoute()),);
                        }
                      ),
                      GestureDetector(
                        child: Container(
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
                                Container(child: Text('${mois}%', style: TextStyle(fontSize: 30, color: Colors.white)))
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
                        onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context) => MoistureRoute()),);
                        }
                      )
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


