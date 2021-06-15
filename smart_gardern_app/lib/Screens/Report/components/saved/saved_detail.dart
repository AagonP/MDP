import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smart_gardern_app/Screens/Report/components/notifier.dart';
import 'package:smart_gardern_app/Screens/Report/components/saved/EditNote.dart';
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
        pic = "assets/images/soil.png";
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
                Navigator.of(context).pop();
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
                  left: size.width * 0.06,
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
                  left: size.width * 0.06,
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
                    child: DataTable(
                      columnSpacing: 10,
                      columns: [
                        DataColumn(
                            label: Text(
                          "Data",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        )),
                        DataColumn(
                            label: Image.asset(
                          pic,
                          height: size.height * 0.1,
                          width: size.width * 0.1,
                          scale: 0.5,
                        )),
                        if (widget.name == "TEMP-HUMID")
                          DataColumn(
                              label: Image.asset(
                            "assets/images/water.png",
                            height: size.height * 0.1,
                            width: size.width * 0.1,
                            scale: 0.5,
                          )),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text(
                            "MAX Value",
                            style: const TextStyle(fontSize: 15.0),
                          )),
                          DataCell(Text(
                            (widget.name == "TEMP-HUMID")
                                ? double.parse(widget.max.split("-")[0])
                                        .toStringAsFixed(1) +
                                    widget.unt.split("-")[0]
                                : widget.max +
                                    ((widget.unt != 'nan') ? widget.unt : ""),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          )),
                          if (widget.name == "TEMP-HUMID")
                            DataCell(Text(
                              double.parse(widget.max.split("-")[1])
                                      .toStringAsFixed(1) +
                                  widget.unt.split("-")[1],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            )),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(
                            "MEAN Value",
                            style: const TextStyle(fontSize: 15.0),
                          )),
                          DataCell(Text(
                            (widget.name == "TEMP-HUMID")
                                ? double.parse(widget.mean.split("-")[0])
                                        .toStringAsFixed(1) +
                                    widget.unt.split("-")[0]
                                : double.parse(widget.mean).toStringAsFixed(1) +
                                    ((widget.unt != 'nan') ? widget.unt : ""),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          )),
                          if (widget.name == "TEMP-HUMID")
                            DataCell(Text(
                              double.parse(widget.mean.split("-")[1])
                                      .toStringAsFixed(1) +
                                  widget.unt.split("-")[1],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            )),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(
                            "MIN Value",
                            style: const TextStyle(fontSize: 15.0),
                          )),
                          DataCell(Text(
                            (widget.name == "TEMP-HUMID")
                                ? widget.min.split("-")[0] +
                                    widget.unt.split("-")[0] +
                                    '-' +
                                    widget.min.split("-")[1] +
                                    widget.unt.split("-")[1]
                                : widget.min +
                                    ((widget.unt != 'nan') ? widget.unt : ""),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          )),
                          if (widget.name == "TEMP-HUMID")
                            DataCell(Text(
                              double.parse(widget.min.split("-")[1])
                                      .toStringAsFixed(1) +
                                  widget.unt.split("-")[1],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            )),
                        ]),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.42,
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
                          height: size.height * 0.28,
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
