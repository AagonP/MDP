import 'package:flutter/foundation.dart';

class Plant {
  String commonName;
  String familyName;
  String sciName;
  String meanLifeSpan;
  String firstHarvestExpected;
  String lastHarvestExpected;
  String height;
  String spread;
  String rowSpacing;
  String imageURL;
  String description;

  Plant(
      this.commonName,
      this.familyName,
      this.sciName,
      this.meanLifeSpan,
      this.firstHarvestExpected,
      this.lastHarvestExpected,
      this.height,
      this.spread,
      this.rowSpacing,
      this.imageURL,
      this.description);
}

// These list will only be used once so no need to update it with ChangeNotifier

class PlantModel extends ChangeNotifier {
  List<Plant> exploredPlants = [];
  List<Plant> categoryPlants = [];
  List<Plant> _plants = [
    Plant(
      "Carrot",
      "Apiaceae",
      "Daucus carota",
      "20",
      "17",
      "21",
      "10",
      "5",
      "5",
      "https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
      "The carrot is a root vegetable. It is usually orange in color, but some cultivars are purple, black, red, white, and yellow. The most commonly eaten part of the plant is the taproot, but the greens are sometimes eaten as well. The leaves appear first, and the taproot grows more slowly beneath the soil. Fast-growing cultivars mature within three months of sowing the seed. Slower-maturing cultivars are harvested four months after sowing.",
    ),
    Plant(
      "Carrot",
      "Apiaceae",
      "Daucus carota",
      "20",
      "17",
      "21",
      "10",
      "5",
      "5",
      "https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
      "The carrot is a root vegetable. It is usually orange in color, but some cultivars are purple, black, red, white, and yellow. The most commonly eaten part of the plant is the taproot, but the greens are sometimes eaten as well. The leaves appear first, and the taproot grows more slowly beneath the soil. Fast-growing cultivars mature within three months of sowing the seed. Slower-maturing cultivars are harvested four months after sowing.",
    ),
    Plant(
      "Carrot",
      "Apiaceae",
      "Daucus carota",
      "20",
      "17",
      "21",
      "10",
      "5",
      "5",
      "https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
      "The carrot is a root vegetable. It is usually orange in color, but some cultivars are purple, black, red, white, and yellow. The most commonly eaten part of the plant is the taproot, but the greens are sometimes eaten as well. The leaves appear first, and the taproot grows more slowly beneath the soil. Fast-growing cultivars mature within three months of sowing the seed. Slower-maturing cultivars are harvested four months after sowing.",
    ),
  ];
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
