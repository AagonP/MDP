import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Screens/Report/components/data.dart';
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
        title: Text('Report Management'),
      ),
      body: Body(),
    );
  }
}
