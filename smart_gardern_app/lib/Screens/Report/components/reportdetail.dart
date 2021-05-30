import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Screens/Report/report_screen.dart';

class ReportDetail extends StatefulWidget {
  final detail;
  final na;
  const ReportDetail({Key? key, required this.detail, required this.na})
      : super(key: key);
  @override
  _ReportDetail createState() => _ReportDetail();
}

class _ReportDetail extends State<ReportDetail> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: <Widget>[
        Positioned(
          child: Image.asset(
            "assets/images/plant_bg.jpeg",
            width: size.width,
            height: size.height,
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: new AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, size: 30.0, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return ReportScreen();
                  }),
                );
              },
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
        ),
        Positioned(
          top: size.height * 0.25,
          child: Container(
            width: size.width,
            height: size.height * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(29),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: size.height * 0.25 * 0.1,
                  left: size.width * 0.1,
                  right: 0,
                  child: Container(
                    child: Row(
                      children: [
                        Text(
                          widget.na,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.12,
                  left: 0,
                  right: 0,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              "assets/images/shower.png",
                              height: size.height * 0.1,
                              width: size.width * 0.1,
                              scale: 0.1,
                            ),
                            Text("Last watering"),
                            Text(widget.detail["wt"].toString() +
                                " " +
                                ((widget.detail["wt"] > 1) ? "hours" : "hour"))
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              "assets/images/water.png",
                              height: size.height * 0.1,
                              width: size.width * 0.1,
                              scale: 0.1,
                            ),
                            Text("Moisture"),
                            Text(widget.detail["moisture"].toString() + "%")
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              "assets/images/sun.png",
                              height: size.height * 0.1,
                              width: size.width * 0.1,
                              scale: 0.1,
                            ),
                            Text("Light"),
                            Text(widget.detail["light"].toString())
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              "assets/images/temperature.png",
                              height: size.height * 0.1,
                              width: size.width * 0.1,
                              scale: 0.1,
                            ),
                            Text("Temperature"),
                            Text(widget.detail["temp"].toString() + "C")
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.33,
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          "More Information:",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        Text(widget.detail["infor"].toString()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
