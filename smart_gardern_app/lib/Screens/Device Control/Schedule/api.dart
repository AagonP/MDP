import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_gardern_app/Models/event.dart';
import 'package:flutter/material.dart';

getEvents() async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('event').get();

  List<Event> _eventList = [];

  snapshot.docs.forEach((document) {
    var data = document.data() as dynamic;
    Event event = Event.fromMap(data, document.id);
    _eventList.add(event);
  });
  return _eventList;
}

deleteEvent(String id) async {
  await FirebaseFirestore.instance.collection("event").doc(id).delete();
}

addEvent(data) async {
  await FirebaseFirestore.instance.collection('event').add(data.toMap());
}
