import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:smart_gardern_app/Models/event.dart';
import 'package:flutter/material.dart';

class DataSource extends CalendarDataSource {
  DataSource(List<Event> source) {
    appointments = source;
  }

  @override
  bool isAllDay(int index) => appointments![index].isAllDay;

  @override
  String getSubject(int index) => appointments![index].eventName;

  @override
  Color getColor(int index) => appointments![index].background;

  @override
  String getNotes(int index) => appointments![index].description;

  @override
  DateTime getStartTime(int index) => appointments![index].from;

  @override
  DateTime getEndTime(int index) => appointments![index].to;
}
