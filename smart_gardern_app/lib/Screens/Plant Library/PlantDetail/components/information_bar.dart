import 'package:flutter/material.dart';

import '../../../../Models/plant.dart';
import '../../../../constant.dart';
import 'information_tile.dart';

class InformationBar extends StatelessWidget {
  const InformationBar({
    Key? key,
    required this.selectedPlant,
  }) : super(key: key);

  final Plant selectedPlant;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.7 * 0.2,
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding - 10, vertical: kDefaultPadding),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          InformationTile(
            text: "Height",
            value: selectedPlant.height,
            icon: Icons.date_range,
            unit: "cm",
          ),
          InformationTile(
            text: "Spread",
            value: selectedPlant.spread,
            icon: Icons.date_range,
            unit: "cm",
          ),
          InformationTile(
            text: "Row Spacing",
            value: selectedPlant.rowSpacing,
            icon: Icons.date_range,
            unit: "cm",
          ),
          InformationTile(
            text: "Medium Life Span",
            value: selectedPlant.meanLifeSpan,
            icon: Icons.date_range,
            unit: "week",
          ),
          InformationTile(
            text: "First Harvest Expected",
            value: selectedPlant.firstHarvestExpected,
            icon: Icons.date_range,
            unit: "week",
          ),
          InformationTile(
            text: "Last Harvest Expected",
            value: selectedPlant.lastHarvestExpected,
            icon: Icons.date_range,
            unit: "week",
          ),
        ],
      ),
    );
  }
}
