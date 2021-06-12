import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smart_gardern_app/Screens/Report/components/notifier.dart';
import 'package:smart_gardern_app/Screens/Report/components/saved/EditNote.dart';
import 'package:smart_gardern_app/Screens/Report/components/saved/saved_screen.dart';
import 'package:provider/provider.dart';

class ReportDetail extends StatefulWidget {
  final String name;
  final String date;
  final String max;
  final String mean;
  final String min;
  final String did;
  final String unt;
  final String rid;
  final String infor;
  const ReportDetail({
    Key? key,
    required this.name,
    required this.date,
    required this.max,
    required this.mean,
    required this.min,
    required this.did,
    required this.unt,
    required this.rid,
    required this.infor,
  }) : super(key: key);
  @override
  _ReportDetail createState() => _ReportDetail();
}

class _ReportDetail extends State<ReportDetail> {
  @override
  Widget build(BuildContext context) {
    // final GlobalKey<State<StatefulWidget>> repaintBoundary = new GlobalKey();
    Size size = MediaQuery.of(context).size;
    String pic = "";
    switch (widget.name) {
      case "LIGHT":
        pic = "assets/images/sun.png";
        break;
      case "SOIL":
        pic = "assets/images/water.png";
        break;
      case "TEMP-HUMID":
        pic = "assets/images/temperature.png";
        break;
    }
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
                    return SavedScreen();
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
                          "Sensor: " + widget.name,
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
                  top: size.height * 0.1,
                  left: size.width * 0.1,
                  right: 0,
                  child: Container(
                    child: Row(
                      children: [
                        Text(
                          "Date: " + widget.date,
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
                  top: size.height * 0.15,
                  left: size.width * 0,
                  right: 0,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              pic,
                              height: size.height * 0.1,
                              width: size.width * 0.1,
                              scale: 0.12,
                            ),
                            Text(
                              "Max",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                // fontSize: 25.0,
                              ),
                            ),
                            Text(
                              (widget.name == "TEMP-HUMID")
                                  ? widget.max.split("-")[0] +
                                      widget.unt.split("-")[0] +
                                      '-' +
                                      widget.max.split("-")[1] +
                                      widget.unt.split("-")[1]
                                  : widget.max +
                                      ((widget.unt != 'nan') ? widget.unt : ""),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                // fontSize: 25.0,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              pic,
                              height: size.height * 0.1,
                              width: size.width * 0.1,
                              scale: 0.12,
                            ),
                            Text(
                              "Mean: ",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                // fontSize: 25.0,
                              ),
                            ),
                            Text(
                              (widget.name == "TEMP-HUMID")
                                  ? widget.mean.split("-")[0] +
                                      widget.unt.split("-")[0] +
                                      '-' +
                                      widget.mean.split("-")[1] +
                                      widget.unt.split("-")[1]
                                  : widget.mean +
                                      ((widget.unt != 'nan') ? widget.unt : ""),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                // fontSize: 25.0,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              pic,
                              height: size.height * 0.1,
                              width: size.width * 0.1,
                              scale: 0.12,
                            ),
                            Text(
                              "Min",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                // fontSize: 25.0,
                              ),
                            ),
                            Text(
                              (widget.name == "TEMP-HUMID")
                                  ? widget.min.split("-")[0] +
                                      widget.unt.split("-")[0] +
                                      '-' +
                                      widget.min.split("-")[1] +
                                      widget.unt.split("-")[1]
                                  : widget.min +
                                      ((widget.unt != 'nan') ? widget.unt : ""),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                // fontSize: 25.0,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.30,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, left: 3.0),
                        child: Row(
                          children: <Widget>[
                            Text("More Information",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.black),
                                textAlign: TextAlign.left),
                          ],
                        ),
                      ),
                      new Container(
                        child: SizedBox(
                          width: size.width * 1,
                          height: size.height * 0.3,
                          child: Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            color: Colors.white,
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: InkWell(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(children: [
                                      setNoteText(widget.rid),
                                    ]),
                                  )
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditNotesView(
                                            str: widget.infor.toString(),
                                            name: widget.name,
                                            id: widget.rid)));
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget setNoteText(rid) {
    ReportNotifier reportNotifier =
        Provider.of<ReportNotifier>(context, listen: false);
    String txt = "";
    for (var i in reportNotifier.savedList) {
      if (i.rid == rid) {
        txt = i.infor;
      }
    }
    return new Container(
      padding: const EdgeInsets.all(4.0),
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Column(
        children: <Widget>[
          new Text(
            txt,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontFamily: 'Roboto'),
          ),
        ],
      ),
    );
  }
}
