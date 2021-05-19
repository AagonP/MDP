import 'package:flutter/material.dart';
import 'package:smart_gardern_app/screens/Report/components/reportdetail.dart';

class ReportDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Detail'),
      ),
      body: ReportDetail(),
    );
  }
}
