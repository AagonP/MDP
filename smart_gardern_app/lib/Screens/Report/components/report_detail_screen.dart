import 'package:flutter/material.dart';
import 'package:smart_gardern_app/screens/Report/components/reportdetail.dart';

class ReportDetailScreen extends StatelessWidget {
  final detail;
  const ReportDetailScreen({Key? key, required this.detail}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Detail'),
      ),
      body: ReportDetail(this.detail),
    );
  }
}
