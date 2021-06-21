import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Screens/Plant%20Library/SavedPlants/saved_plants.dart';

import '../../../../components/custtom_icon_button.dart';
import '../../../../constant.dart';
import '../../../../Models/plant.dart';
import 'background.dart';
import 'information_bar.dart';

Future<void> deletePlant(selectedPlant) async {
  var userToken = FirebaseAuth.instance.currentUser!.email;
  CollectionReference<Map<String, dynamic>> users =
      FirebaseFirestore.instance.collection('users');
  DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      await users.doc(userToken).get();
  if (documentSnapshot.data()!.isNotEmpty) {
    final List<dynamic> savedPlants = documentSnapshot.data()!['saved_plants'];
    savedPlants.removeWhere((element) => element == selectedPlant.commonName);
    await users.doc(userToken).update({'saved_plants': savedPlants});
    await users
        .doc(userToken)
        .collection('plants')
        .where('common_name', isEqualTo: selectedPlant.commonName)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  }
}

class SavedBody extends StatelessWidget {
  final Plant selectedPlant;
  final index;

  const SavedBody({Key? key, required this.selectedPlant, this.index})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final removeSnackBar = SnackBar(
      content: Text('Saved plant removed!'),
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
                    await deletePlant(selectedPlant);
                    ScaffoldMessenger.of(context).showSnackBar(removeSnackBar);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SavedPlantScreen();
                        },
                      ),
                    );
                  },
                  icon: Icons.delete,
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
