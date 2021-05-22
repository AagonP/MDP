import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Screens/Report/components/reportdetail.dart';
import 'package:smart_gardern_app/screens/Report/components/reportdetail_screen.dart';

class Report extends StatefulWidget {
  final String name;
  final String device;
  final String date;
  final detail;
  const Report(
      {Key? key,
      required this.name,
      required this.device,
      required this.date,
      required this.detail})
      : super(key: key);
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: <Widget>[
        Card(
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          color: Colors.white,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 8.0, 15.0, 8.0),
                child: Image.asset(
                  'assets/images/plant.png',
                  width: size.width * 0.1,
                  height: size.height * 0.08,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 8.0, 15.0, 8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              "Report: " +
                                  widget.name.toString() +
                                  "\nDevide: " +
                                  widget.device.toString() +
                                  "\nDate: " +
                                  widget.date.toString(),
                              textAlign: TextAlign.left),
                        ],
                      ),
                    ]),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(80.0, 8.0, 10.0, 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return Reportdetail_Screen(detail: widget.detail);
                        }),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: SizedBox(
                          height: size.height * 0.06,
                          width: size.width * 0.1,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text("More"),
                          )),
                    ),
                  ))
            ],
          ),
        )
      ],
    );
  }
}
