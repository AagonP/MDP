import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Screens/Report/components/reportdetail.dart';

class Reportdetail_Screen extends StatefulWidget {
  final detail;
  const Reportdetail_Screen({Key? key, required this.detail}) : super(key: key);

  @override
  _ReportDetailScreen createState() => _ReportDetailScreen();
}

class _ReportDetailScreen extends State<Reportdetail_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Detail'),
      ),
      body: ReportDetail(detail: widget.detail),
    );
  }
}
