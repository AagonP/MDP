import 'package:flutter/material.dart';
import 'package:smart_gardern_app/screens/Report/components/report_detail_screen.dart';

class Report extends StatefulWidget {
  const Report({
    Key? key,
  }) : super(key: key);
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Card(
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
                  width: size.width * 0.12,
                  height: size.height * 0.1,
                ),
              ),
              Column(children: [
                Text("Report: Report1", textAlign: TextAlign.left),
                Text("Devide: Device1", textAlign: TextAlign.left),
                Text("Date: 16/5/2021", textAlign: TextAlign.left),
              ]),
              Padding(
                  padding: const EdgeInsets.fromLTRB(80.0, 8.0, 10.0, 8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return ReportDetailScreen();
                          }),
                        );
                      },
                      child: Image.asset(
                        'assets/images/plant.png',
                        width: size.width * 0.1,
                        height: size.height * 0.1,
                      )))
            ],
          ),
        )
      ],
    );
  }
}
