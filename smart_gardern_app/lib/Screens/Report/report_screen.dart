import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Screens/Report/components/saved/saved_screen.dart';
import 'package:smart_gardern_app/Screens/Report/components/body.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreen createState() => _ReportScreen();
}

class _ReportScreen extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double wid = size.width.toDouble();
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return SavedScreen();
              }),
            ),
            child: Text("Saved"),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
        title: Text('Report Management'),
      ),
      body: BodyReport(),
    );
  }
}
