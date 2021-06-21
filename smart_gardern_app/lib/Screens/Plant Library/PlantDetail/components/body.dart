import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../components/custtom_icon_button.dart';
import '../../../../constant.dart';
import '../../../../Models/plant.dart';
import 'background.dart';
import 'information_bar.dart';

Future<void> savePlants(selectedPlant) async {
  //
  var userToken = FirebaseAuth.instance.currentUser!.email;
  CollectionReference<Map<String, dynamic>> users =
      FirebaseFirestore.instance.collection('users');
  final plantsRef = FirebaseFirestore.instance
      .collection('users')
      .doc(userToken)
      .collection('plants')
      .withConverter<Plant>(
        fromFirestore: (snapshot, _) => Plant.fromJson(snapshot.data()!),
        toFirestore: (plant, _) => plant.toJson(),
      );
  // Get document
  DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      await users.doc(userToken).get();
  if (!documentSnapshot.exists) {
    await users.doc(userToken).set(
      {
        'saved_plants': [selectedPlant.commonName],
      },
    );
    plantsRef.add(selectedPlant);
  } else {
    final List<dynamic> savedPlants = documentSnapshot.data()!['saved_plants'];
    if (!savedPlants.contains(selectedPlant.commonName)) {
      savedPlants.add(selectedPlant.commonName);
      users.doc(userToken).set(
        {
          'saved_plants': savedPlants,
        },
      );
      plantsRef.add(selectedPlant);
    }
  }
}

class Body extends StatelessWidget {
  final Plant selectedPlant;

  const Body({Key? key, required this.selectedPlant}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final addSnackBar = SnackBar(
      content: Text('Plant saved!'),
      duration: Duration(seconds: 1),
    );
    return BackGround(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${selectedPlant.commonName[0].toUpperCase()}${selectedPlant.commonName.substring(1)}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                CustomIconButton(
                  onPressed: () async {
                    await savePlants(selectedPlant);
                    ScaffoldMessenger.of(context).showSnackBar(addSnackBar);
                  },
                  icon: Icons.bookmark,
                ),
              ],
            ),
          ),
          Text(
            "${selectedPlant.genus}",
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
          ),
          InformationBar(selectedPlant: selectedPlant),
          Text(
            "Description",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 10),
          ),
          Container(
            height: size.height * 0.7 * 0.5,
            child: SingleChildScrollView(
              child: Text(
                "${selectedPlant.description}",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
