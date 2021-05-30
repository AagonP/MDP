import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Screens/Home/home_screen.dart';
import 'package:smart_gardern_app/screens/Report/components/body.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreen createState() => _ReportScreen();
}

class _ReportScreen extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return HomeScreen();
            }),
          ),
        ),
        title: Text('Report Management'),
      ),
      body: Body(),
    );
  }
}
