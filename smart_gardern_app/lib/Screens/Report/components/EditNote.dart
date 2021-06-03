import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_gardern_app/Screens/Report/components/api.dart';
import 'package:smart_gardern_app/Screens/Report/components/notifier.dart';
import 'package:provider/provider.dart';

class EditNotesView extends StatefulWidget {
  final String str;
  final String name;
  final String id;

  const EditNotesView(
      {Key? key, required this.str, required this.name, required this.id})
      : super(key: key);

  @override
  _EditNotesViewState createState() => _EditNotesViewState();
}

class _EditNotesViewState extends State<EditNotesView> {
  TextEditingController _notesController = new TextEditingController();

  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _notesController.text = widget.str;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.lightGreenAccent,
        child: Hero(
          tag: "TripNotes-${widget.name}",
          transitionOnUserGestures: true,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  buildHeading(context),
                  buildNotesText(),
                  buildSubmitButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeading(context) {
    return Material(
      color: Colors.lightGreenAccent,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                "More Information",
                style: TextStyle(
                    fontSize: 24, color: Colors.black, fontFamily: "roboto"),
              ),
            ),
            FlatButton(
              child: Icon(Icons.close, color: Colors.black, size: 30),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget buildNotesText() {
    return Material(
      color: Colors.lightGreenAccent,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
          maxLines: null,
          controller: _notesController,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          cursorColor: Colors.black,
          autofocus: true,
          style: TextStyle(color: Colors.black, fontFamily: "Roboto"),
        ),
      ),
    );
  }

  Widget buildSubmitButton(context) {
    void updated(String nText) {
      var user = FirebaseAuth.instance.currentUser;
      var uid;
      if (user != null) {
        uid = user.uid;
      }
      ReportNotifier reportNotifier =
          Provider.of<ReportNotifier>(context, listen: false);
      updateReport(reportNotifier, nText, widget.id);
      final CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("User");
      collectionReference
          .doc(uid)
          .collection('Report')
          .doc(widget.id)
          .update({'detail.infor': nText}).whenComplete(() async {
        print("Update Completed!");
      }).catchError((e) => print("Problem: $e"));
    }

    return Material(
      color: Colors.lightGreenAccent,
      child: RaisedButton(
        child: Text("Save"),
        color: Colors.green,
        onPressed: () async {
          updated(_notesController.text);

          Navigator.of(context).pop();
        },
      ),
    );
  }
}
