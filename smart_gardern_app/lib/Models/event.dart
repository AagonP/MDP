import 'package:flutter/material.dart';
import 'package:smart_gardern_app/constant.dart';

class Event {
  Event(
      {required this.from,
      required this.to,
      this.background = kPrimaryColor,
      this.isAllDay = false,
      this.eventName = '',
      this.description = ''});

  final String eventName;
  final DateTime from;
  final Color background;
  final DateTime to;
  final bool isAllDay;
  final String description;
}
