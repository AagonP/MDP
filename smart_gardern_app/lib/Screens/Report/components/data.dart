import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Screens/Report/components/report.dart';

class Data extends StatelessWidget {
  List<Widget> makeListWidget(AsyncSnapshot snapshot) {
    return snapshot.data.docs.map<Widget>((document) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Report(
              name: document["name"].toString(),
              device: document["device"].toString(),
              date: document["date"].toString(),
              detail: document["detail"])
        ],
      );
    }).toList();
  }

  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    var uid;
    if (user != null) {
      uid = user.uid;
    }

    return Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('User')
            .doc(uid.toString())
            .collection("Report")
            .snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              return ListView(
                controller: _scrollController,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: makeListWidget(snapshot),
              );
          }
        },
      ),
    );
  }
}
