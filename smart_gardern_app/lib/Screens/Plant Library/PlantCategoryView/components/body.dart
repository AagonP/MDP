import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Models/plant.dart';
import 'package:provider/provider.dart';
import 'package:smart_gardern_app/Screens/Plant%20Library/Overview/components/search_bar.dart';
import 'package:smart_gardern_app/Screens/Plant%20Library/Overview/components/top_bar.dart';
import 'package:smart_gardern_app/Screens/Plant%20Library/PlantDetail/plant_detail_screen.dart';
import 'package:smart_gardern_app/components/CustomListTile.dart';
import 'package:smart_gardern_app/constant.dart';

Future<List<Plant>> fetchSameGenusPlants(String genus) async {
  CollectionReference<Map<String, dynamic>> plants =
      FirebaseFirestore.instance.collection('Plants');
  List<Plant> sameGenusPlants = [];
  await plants
      .where('genus', isEqualTo: genus)
      .get()
      .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      sameGenusPlants.add(Plant(
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
  return sameGenusPlants;
}

class Body extends StatelessWidget {
  final genus;

  const Body({Key? key, this.genus}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PlantListView(genus: genus);
  }
}

class PlantListView extends StatefulWidget {
  const PlantListView({
    Key? key,
    this.genus,
  }) : super(key: key);
  final genus;
  @override
  _PlantListViewState createState() => _PlantListViewState();
}

class _PlantListViewState extends State<PlantListView> {
  late Future<List<Plant>> sameGenusPlants;
  @override
  void initState() {
    super.initState();
    sameGenusPlants = fetchSameGenusPlants(widget.genus);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Plant>>(
      future: sameGenusPlants,
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
