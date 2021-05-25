import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Models/plant.dart';
import 'package:provider/provider.dart';
import '../../../../constant.dart';
import 'plant_card.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SavedPlantModel>(
      builder: (context, plant, child) {
        // List of saved plants
        final items = plant.getList();
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
            vertical: kDefaultPadding,
          ),
          child: ListView.builder(
            itemCount: items.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return PlantCard(selectedPlant: items[index], index: index);
            },
          ),
        );
      },
    );
  }
}
