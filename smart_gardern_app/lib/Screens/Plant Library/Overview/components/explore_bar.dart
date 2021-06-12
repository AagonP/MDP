import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../Models/plant.dart';
import '../../PlantDetail/plant_detail_screen.dart';
import '../../../../constant.dart';
import '../../../../components/CustomListTile.dart';

Future<List<Plant>> fetchRandomPlants() async {
  QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('PlantInfo').limit(1).get();
  final noGenus = int.parse(querySnapshot.docs[0].data()['no_genus']);
  final genuses = querySnapshot.docs[0].data()['genuses'].split(', ');
  final plantsRef =
      FirebaseFirestore.instance.collection('Plants').withConverter<Plant>(
            fromFirestore: (snapshot, _) => Plant.fromJson(snapshot.data()!),
            toFirestore: (plant, _) => plant.toJson(),
          );
  List<Plant> demoPlants = [];
  // Generate random indexes
  final noRandomPlants = 10;
  var random = Random();
  var randomPlantIndexes = <int>{};
  while (randomPlantIndexes.length != noRandomPlants) {
    randomPlantIndexes.add(random.nextInt(noGenus));
  }
  // Query list of random plants
  for (int i = 0; i < noRandomPlants; i++) {
    await plantsRef
        .where('genus',
            isEqualTo: genuses[randomPlantIndexes.elementAt(i)].split('\'')[1])
        .limit(1)
        .get()
        .then((QuerySnapshot<Plant> querySnapshot) {
      demoPlants.add(querySnapshot.docs[0].data());
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
    return FutureBuilder<List<Plant>>(
      future: demoPlants,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ExplorePlantListView(snapshot: snapshot);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }
}

class ExplorePlantListView extends StatelessWidget {
  const ExplorePlantListView({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  final snapshot;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              // Navigate to PlantDetailScreen()
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
  }
}
