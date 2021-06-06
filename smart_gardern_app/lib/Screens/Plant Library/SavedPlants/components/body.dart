import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Models/plant.dart';
import 'package:provider/provider.dart';
import '../../../../constant.dart';
import 'plant_card.dart';

Future<List<Plant>> fetchSavedPlants() async {
  var userToken = FirebaseAuth.instance.currentUser!.email;
  CollectionReference<Map<String, dynamic>> plants = FirebaseFirestore.instance
      .collection('users')
      .doc(userToken)
      .collection('plants');
  List<Plant> savedPlants = [];
  await plants.get().then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      savedPlants.add(Plant(
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
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: kDefaultPadding,
            ),
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return PlantCard(
                    selectedPlant: snapshot.data![index], index: index);
              },
            ),
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
