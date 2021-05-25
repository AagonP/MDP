import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Models/plant.dart';
import 'package:smart_gardern_app/Screens/Plant%20Library/PlantDetail/saved_plant_detail_screen.dart';

import '../../../../constant.dart';

class PlantCard extends StatelessWidget {
  const PlantCard({
    Key? key,
    required this.selectedPlant,
    this.index,
  }) : super(key: key);

  final Plant selectedPlant;
  final index;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kPrimaryColor,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(selectedPlant.imageURL),
        ),
        trailing: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        title: Text(
          selectedPlant.commonName,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          selectedPlant.familyName,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return SavedPlantDetailScreen(
                  selectedPlant: selectedPlant,
                  index: index,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
