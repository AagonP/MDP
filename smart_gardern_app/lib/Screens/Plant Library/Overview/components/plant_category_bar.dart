import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Models/plant.dart';
import '../../../../constant.dart';
import '../../../../components/CustomListTile.dart';

class PlantCategoryBar extends StatefulWidget {
  const PlantCategoryBar({
    Key? key,
  }) : super(key: key);

  @override
  _PlantCategoryBarState createState() => _PlantCategoryBarState();
}

class _PlantCategoryBarState extends State<PlantCategoryBar> {
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
                text: items[index].familyName,
                imageURL: items[index].imageURL,
              );
            },
          ),
        );
      },
    );
  }
}
