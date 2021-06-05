import 'dart:html';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Body extends StatelessWidget {
  final searchKey;

  const Body({Key? key, required this.searchKey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    CollectionReference<Map<String, dynamic>> plants =
        FirebaseFirestore.instance.collection('plants');
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: plants.where('commonName', isEqualTo: searchKey).get(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData) {
          return Text("Document does not exist + $searchKey");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          var data = snapshot.data!.docs;
          return Center(
            child: Text("Common Name: $data}"),
          );
        }

        return Text("loading");
      },
    );
  }
}
