import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_gardern_app/Models/plant.dart';
import 'package:smart_gardern_app/Screens/Plant%20Library/PlantDetail/plant_detail_screen.dart';
import 'package:smart_gardern_app/components/CustomListTile.dart';

import '../../../../constant.dart';

Future<List<Plant>> fetchSearchPlants(String searchKey) async {
  CollectionReference<Map<String, dynamic>> plants =
      FirebaseFirestore.instance.collection('Plants');
  List<Plant> resultPlants = [];
  await plants
      .where('genus',
          isEqualTo: '${searchKey[0].toUpperCase()}${searchKey.substring(1)}')
      .get()
      .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      resultPlants.add(Plant(
          doc.data()['common_name'],
          doc.data()['genus'],
          doc.data()['description'],
          doc.data()['annual'],
          doc.data()['median lifespan'],
          doc.data()['first harvest expected'],
          doc.data()['last harvest expected'],
          doc.data()['height'],
          doc.data()['spread'],
          doc.data()['row Spacing'],
          doc.data()['imageURL']));
    });
  });
  await plants
      .where('common_name', isEqualTo: searchKey.toLowerCase())
      .get()
      .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      resultPlants.add(Plant(
          doc.data()['common_name'],
          doc.data()['genus'],
          doc.data()['description'],
          doc.data()['annual'],
          doc.data()['median lifespan'],
          doc.data()['first harvest expected'],
          doc.data()['last harvest expected'],
          doc.data()['height'],
          doc.data()['spread'],
          doc.data()['row Spacing'],
          doc.data()['imageURL']));
    });
  });
  return resultPlants;
}

class Body extends StatelessWidget {
  final searchKey;

  const Body({Key? key, required this.searchKey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CollectionReference<Map<String, dynamic>> plants =
        FirebaseFirestore.instance.collection('Plants');
    return FutureBuilder<List<Plant>>(
      future: fetchSearchPlants(searchKey),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: kDefaultPadding, horizontal: kDefaultPadding),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(
                    snapshot.data!.length,
                    (index) {
                      return CustomListTile(
                        imageURL: snapshot.data![index].imageURL,
                        onTapHandler: () {
                          // Refactor this
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return PlantDetailScreen(
                                  selectedPlant: snapshot.data![index],
                                );
                              },
                            ),
                          );
                        },
                        text: snapshot.data![index].commonName,
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }
}
