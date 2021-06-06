import 'package:flutter/foundation.dart';

class Plant {
  String commonName;
  String genus;
  String description;
  String annual;
  String meanLifeSpan;
  String firstHarvestExpected;
  String lastHarvestExpected;
  String height;
  String spread;
  String rowSpacing;
  String imageURL;

  Plant(
      this.commonName,
      this.genus,
      this.description,
      this.annual,
      this.meanLifeSpan,
      this.firstHarvestExpected,
      this.lastHarvestExpected,
      this.height,
      this.spread,
      this.rowSpacing,
      this.imageURL);
}

// These list will only be used once so no need to update it with ChangeNotifier

class PlantModel extends ChangeNotifier {
  List<Plant> _plants = [];
  List<Plant> getList() {
    return _plants;
  }
}

class SavedPlantModel extends ChangeNotifier {
  List<Plant> _plants = [];
  List<Plant> getList() {
    return _plants;
  }

  void add(Plant plant) {
    _plants.add(plant);
    _plants = _plants.toSet().toList();
    notifyListeners();
  }

  void remove(int index) {
    _plants.removeAt(index);
    notifyListeners();
  }
}
