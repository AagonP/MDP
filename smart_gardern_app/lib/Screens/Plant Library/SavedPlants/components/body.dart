import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Models/plant.dart';
import '../../../../constant.dart';
import 'plant_card.dart';

Future<List<Plant>> fetchSavedPlants() async {
  var userToken = FirebaseAuth.instance.currentUser!.email;
  final plantsRef = FirebaseFirestore.instance
      .collection('users')
      .doc(userToken)
      .collection('plants')
      .withConverter<Plant>(
        fromFirestore: (snapshot, _) => Plant.fromJson(snapshot.data()!),
        toFirestore: (plant, _) => plant.toJson(),
      );
  List<Plant> savedPlants = [];
  await plantsRef.get().then((QuerySnapshot<Plant> querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      savedPlants.add(doc.data());
    });
  });
  return savedPlants;
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SavedPlantCards();
  }
}

class SavedPlantCards extends StatefulWidget {
  const SavedPlantCards({
    Key? key,
  }) : super(key: key);

  @override
  _SavedPlantCardsState createState() => _SavedPlantCardsState();
}

class _SavedPlantCardsState extends State<SavedPlantCards> {
  late Future<List<Plant>> savedPlants;
  @override
  void initState() {
    super.initState();
    savedPlants = fetchSavedPlants();
  }

  Widget build(BuildContext context) {
    return FutureBuilder<List<Plant>>(
      future: fetchSavedPlants(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SavedPlantsListView(
            snapshot: snapshot,
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner.
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class SavedPlantsListView extends StatelessWidget {
  const SavedPlantsListView({
    Key? key,
    this.snapshot,
  }) : super(key: key);
  final snapshot;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding,
      ),
      child: ListView.builder(
        itemCount: snapshot.data!.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return PlantCard(selectedPlant: snapshot.data![index], index: index);
        },
      ),
    );
  }
}
