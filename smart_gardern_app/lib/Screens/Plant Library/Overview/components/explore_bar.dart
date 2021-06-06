import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Models/plant.dart';
import 'package:provider/provider.dart';

import '../../PlantDetail/plant_detail_screen.dart';
import '../../../../constant.dart';
import '../../../../components/CustomListTile.dart';

Future<List<Plant>> fetchRandomPlants() async {
  CollectionReference<Map<String, dynamic>> plantInfo =
      FirebaseFirestore.instance.collection('PlantInfo');
  CollectionReference<Map<String, dynamic>> plants =
      FirebaseFirestore.instance.collection('Plants');
  List<Plant> demoPlants = [];
  var noGenus;
  var genuses;
  await plantInfo
      .limit(1)
      .get()
      .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    noGenus = int.parse(querySnapshot.docs[0].data()['no_genus']);
    genuses = querySnapshot.docs[0].data()['genuses'].split(', ');
  });
  //Generate random indexes
  final noRandomPlants = 10;
  var random = Random();
  var randomPlantIndexes = <int>{};
  while (randomPlantIndexes.length != noRandomPlants) {
    randomPlantIndexes.add(random.nextInt(noGenus));
  }
  for (int i = 0; i < noRandomPlants; i++) {
    await plants
        .where('genus',
            isEqualTo: genuses[randomPlantIndexes.elementAt(i)].split('\'')[1])
        .limit(1)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      demoPlants.add(Plant(
          querySnapshot.docs[0].data()['common_name'],
          querySnapshot.docs[0].data()['genus'],
          querySnapshot.docs[0].data()['description'],
          querySnapshot.docs[0].data()['annual'],
          querySnapshot.docs[0].data()['median lifespan'],
          querySnapshot.docs[0].data()['first harvest expected'],
          querySnapshot.docs[0].data()['last harvest expected'],
          querySnapshot.docs[0].data()['height'],
          querySnapshot.docs[0].data()['spread'],
          querySnapshot.docs[0].data()['row Spacing'],
          querySnapshot.docs[0].data()['imageURL']));
    });
  }
  return demoPlants;
}

class ExploreBar extends StatefulWidget {
  const ExploreBar({
    Key? key,
  }) : super(key: key);

  @override
  _ExploreBarState createState() => _ExploreBarState();
}

class _ExploreBarState extends State<ExploreBar> {
  late Future<List<Plant>> demoPlants;
  @override
  void initState() {
    super.initState();
    demoPlants = fetchRandomPlants();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<List<Plant>>(
      future: demoPlants,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding, vertical: kDefaultPadding),
            height: size.height * 0.3,
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CustomListTile(
                  text: snapshot.data![index].commonName,
                  imageURL: snapshot.data![index].imageURL,
                  onTapHandler: () {
                    //Refactor this
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return PlantDetailScreen(
                          selectedPlant: snapshot.data![index],
                        );
                      }),
                    );
                  },
                );
              },
            ),
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
