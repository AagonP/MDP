import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../components/custtom_icon_button.dart';
import '../../../../constant.dart';
import '../../../../Models/plant.dart';
import 'background.dart';
import 'information_bar.dart';
import 'package:provider/provider.dart';

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
                    var userToken = FirebaseAuth.instance.currentUser!.email;
                    CollectionReference<Map<String, dynamic>> users =
                        FirebaseFirestore.instance.collection('users');
                    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
                        await users.doc(userToken).get();
                    if (documentSnapshot.data() != null) {
                      final List<dynamic> savedPlants =
                          documentSnapshot.data()!['saved_plants'];
                      if (!savedPlants.contains(selectedPlant.commonName)) {
                        savedPlants.add(selectedPlant.commonName);
                        users.doc(userToken).set(
                          {
                            'saved_plants': savedPlants,
                          },
                        );
                        users.doc(userToken).collection('plants').add({
                          'annual': selectedPlant.annual,
                          'common_name': selectedPlant.commonName,
                          'description': selectedPlant.description,
                          'first harvest expected':
                              selectedPlant.firstHarvestExpected,
                          'genus': selectedPlant.genus,
                          'height': selectedPlant.height,
                          'imageURL': selectedPlant.imageURL,
                          'last harvest expected':
                              selectedPlant.lastHarvestExpected,
                          'median lifespan': selectedPlant.meanLifeSpan,
                          'row Spacing': selectedPlant.rowSpacing,
                          'spread': selectedPlant.spread
                        });
                      }
                    } else {
                      users.doc(userToken).set(
                        {
                          'saved_plants': [selectedPlant.commonName],
                        },
                      );
                      users.doc(userToken).collection('plants').add({
                        'annual': selectedPlant.annual,
                        'common_name': selectedPlant.commonName,
                        'description': selectedPlant.description,
                        'first harvest expected':
                            selectedPlant.firstHarvestExpected,
                        'genus': selectedPlant.genus,
                        'height': selectedPlant.height,
                        'imageURL': selectedPlant.imageURL,
                        'last harvest expected':
                            selectedPlant.lastHarvestExpected,
                        'median lifespan': selectedPlant.meanLifeSpan,
                        'row Spacing': selectedPlant.rowSpacing,
                        'spread': selectedPlant.spread
                      });
                    }

                    ScaffoldMessenger.of(context).showSnackBar(addSnackBar);
                  },
                  icon: Icons.bookmark,
                ),
                // CustomIconButton(
                //   onPressed: () {
                //     print("Export pressed!");
                //   },
                //   icon: Icons.file_download,
                // ),
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
