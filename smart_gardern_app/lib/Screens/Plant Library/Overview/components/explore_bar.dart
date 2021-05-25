import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Models/plant.dart';
import 'package:provider/provider.dart';

import '../../PlantDetail/plant_detail_screen.dart';
import '../../../../constant.dart';
import '../../../../components/CustomListTile.dart';

class ExploreBar extends StatefulWidget {
  const ExploreBar({
    Key? key,
  }) : super(key: key);

  @override
  _ExploreBarState createState() => _ExploreBarState();
}

class _ExploreBarState extends State<ExploreBar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<PlantModel>(
      builder: (context, plant, child) {
        // List of plants
        final items = plant.getList();
        return Container(
          padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding, vertical: kDefaultPadding),
          height: size.height * 0.3,
          child: ListView.builder(
            itemCount: items.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CustomListTile(
                text: items[index].commonName,
                imageURL: items[index].imageURL,
                onTapHandler: () {
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
              );
            },
          ),
        );
      },
    );
  }
}
