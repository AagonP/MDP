import 'package:flutter/material.dart';

import '../../../Models/plant.dart';
import 'components/body.dart';

class PlantDetailScreen extends StatelessWidget {
  final Plant selectedPlant;

  const PlantDetailScreen({
    Key? key,
    required this.selectedPlant,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Body(
          selectedPlant: selectedPlant,
        ),
      ),
    );
  }
}
