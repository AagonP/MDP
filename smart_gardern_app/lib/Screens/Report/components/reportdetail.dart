import 'package:flutter/material.dart';

class ReportDetail extends StatefulWidget {
  final detail;
  const ReportDetail({
    Key? key,
    required this.detail,
  }) : super(key: key);
  @override
  _ReportDetail createState() => _ReportDetail();
}

class _ReportDetail extends State<ReportDetail> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(widget.detail.toString()));
  }
}
