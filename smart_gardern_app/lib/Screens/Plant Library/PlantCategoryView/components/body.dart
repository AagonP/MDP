import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Models/plant.dart';
import 'package:provider/provider.dart';
import 'package:smart_gardern_app/Screens/Plant%20Library/Overview/components/search_bar.dart';
import 'package:smart_gardern_app/Screens/Plant%20Library/Overview/components/top_bar.dart';
import 'package:smart_gardern_app/Screens/Plant%20Library/PlantDetail/plant_detail_screen.dart';
import 'package:smart_gardern_app/components/CustomListTile.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<PlantModel>(
      builder: (context, plant, child) {
        // List of plants
        final items = plant.getList();
        return Column(
          children: [
            TopBar(
              children: [
                SearchBar(),
              ],
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(
                  items.length,
                  (index) {
                    return CustomListTile(
                      imageURL: items[index].imageURL,
                      onTapHandler: () {
                        // Refactor this
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return PlantDetailScreen(
                                selectedPlant: items[index],
                              );
                            },
                          ),
                        );
                      },
                      text: items[index].commonName,
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
