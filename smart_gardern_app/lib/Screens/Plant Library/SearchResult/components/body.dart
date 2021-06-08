import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_gardern_app/Models/plant.dart';
import 'package:smart_gardern_app/Screens/Plant%20Library/PlantDetail/plant_detail_screen.dart';
import 'package:smart_gardern_app/components/CustomListTile.dart';

import '../../../../constant.dart';

Future<List<Plant>> fetchSearchPlants(String searchKey) async {
  final plantsRef =
      FirebaseFirestore.instance.collection('Plants').withConverter<Plant>(
            fromFirestore: (snapshot, _) => Plant.fromJson(snapshot.data()!),
            toFirestore: (plant, _) => plant.toJson(),
          );
  List<Plant> resultPlants = [];
  // Search for same genus
  await plantsRef
      .where('genus',
          isEqualTo: '${searchKey[0].toUpperCase()}${searchKey.substring(1)}')
      .get()
      .then((QuerySnapshot<Plant> querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      resultPlants.add(doc.data());
    });
  });
  // Search for same common name
  await plantsRef
      .where('common_name', isEqualTo: searchKey.toLowerCase())
      .get()
      .then((QuerySnapshot<Plant> querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      resultPlants.add(doc.data());
    });
  });
  return resultPlants;
}

class Body extends StatelessWidget {
  final searchKey;

  const Body({Key? key, required this.searchKey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Plant>>(
      future: fetchSearchPlants(searchKey),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SearchGridView(snapshot: snapshot);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }
}

class SearchGridView extends StatelessWidget {
  const SearchGridView({
    Key? key,
    this.snapshot,
  }) : super(key: key);
  final snapshot;

  @override
  Widget build(BuildContext context) {
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
  }
}
