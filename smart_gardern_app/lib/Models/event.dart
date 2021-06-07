import 'package:flutter/material.dart';
import 'package:smart_gardern_app/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  Event(
      {required this.from,
      required this.to,
      this.background = kPrimaryColor,
      this.eventName = '',
      this.description = '',
      this.id = ''});

  String eventName;
  DateTime from;
  Color background;
  DateTime to;
  String description;
  String id;

  factory Event.fromMap(Map data, String docId) {
    return Event(
        from: data['start'].toDate(),
        to: data['end'].toDate(),
        description: data['description'],
        eventName: data['eventName'],
        background: Color(int.parse(data['background'])),
        id: docId);
  }

  Map<String, dynamic> toMap() {
    return {
      "description": description,
      "background":
          '0x${background.value.toRadixString(16).padLeft(6, '0').toUpperCase()}',
      "eventName": eventName,
      "start": Timestamp.fromDate(from),
      "end": Timestamp.fromDate(to),
      "device_id": "11"
    };
  }
}
