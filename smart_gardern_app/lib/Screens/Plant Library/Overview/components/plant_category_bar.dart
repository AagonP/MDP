import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../PlantCategoryView/plant_category_screen.dart';
import '../../../../Models/plant.dart';
import '../../../../constant.dart';
import '../../../../components/CustomListTile.dart';

Future<List<Plant>> fetchDemoPlants() async {
  QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('PlantInfo').limit(1).get();
  final noGenus = int.parse(querySnapshot.docs[0].data()['no_genus']);
  final genuses = querySnapshot.docs[0].data()['genuses'].split(', ');
  List<Plant> demoPlants = [];
  final plantsRef =
      FirebaseFirestore.instance.collection('Plants').withConverter<Plant>(
            fromFirestore: (snapshot, _) => Plant.fromJson(snapshot.data()!),
            toFirestore: (plant, _) => plant.toJson(),
          );
  for (int i = 0; i < 10; i++) {
    await plantsRef
        .where('genus', isEqualTo: genuses[i].split('\'')[1])
        .limit(1)
        .get()
        .then((QuerySnapshot<Plant> querySnapshot) {
      demoPlants.add(querySnapshot.docs[0].data());
    });
  }
  return demoPlants;
}

class PlantCategoryBar extends StatefulWidget {
  const PlantCategoryBar({
    Key? key,
  }) : super(key: key);

  @override
  _PlantCategoryBarState createState() => _PlantCategoryBarState();
}

class _PlantCategoryBarState extends State<PlantCategoryBar> {
  late Future<List<Plant>> demoPlants;
  @override
  void initState() {
    super.initState();
    demoPlants = fetchDemoPlants();
  }

  Widget build(BuildContext context) {
    return FutureBuilder<List<Plant>>(
      future: demoPlants,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return PlantCategoryListView(snapshot: snapshot);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }
}

class PlantCategoryListView extends StatelessWidget {
  const PlantCategoryListView({
    Key? key,
    this.snapshot,
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
            text: snapshot.data![index].genus,
            imageURL: snapshot.data![index].imageURL,
            onTapHandler: () {
              //Refactor this
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return PlantCategoryScreen(
                        genus: snapshot.data![index].genus);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
