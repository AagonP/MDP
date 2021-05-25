import 'package:flutter/material.dart';
import 'components/saved_body.dart';
import '../../../Models/plant.dart';

class SavedPlantDetailScreen extends StatelessWidget {
  final Plant selectedPlant;
  final index;

  const SavedPlantDetailScreen({
    Key? key,
    required this.selectedPlant,
    this.index,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SavedBody(
          selectedPlant: selectedPlant,
          index: index,
        ),
      ),
    );
  }
}
