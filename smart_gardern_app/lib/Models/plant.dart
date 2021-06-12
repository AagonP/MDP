import 'package:flutter/foundation.dart';

class Plant {
  final String commonName;
  final String genus;
  final String description;
  final String annual;
  final String meanLifeSpan;
  final String firstHarvestExpected;
  final String lastHarvestExpected;
  final String height;
  final String spread;
  final String rowSpacing;
  final String imageURL;

  Plant(
      {required this.commonName,
      required this.genus,
      required this.description,
      required this.annual,
      required this.meanLifeSpan,
      required this.firstHarvestExpected,
      required this.lastHarvestExpected,
      required this.height,
      required this.spread,
      required this.rowSpacing,
      required this.imageURL});

  Plant.fromJson(Map<String, Object?> json)
      : this(
            commonName: json['common_name']! as String,
            genus: json['genus']! as String,
            description: json['description']! as String,
            annual: json['annual']! as String,
            meanLifeSpan: json['median lifespan']! as String,
            firstHarvestExpected: json['first harvest expected']! as String,
            lastHarvestExpected: json['last harvest expected']! as String,
            height: json['height']! as String,
            spread: json['spread']! as String,
            rowSpacing: json['row Spacing']! as String,
            imageURL: json['imageURL']! as String);

  Map<String, Object?> toJson() {
    return {
      'common_name': commonName,
      'genus': genus,
      'description': description,
      'annual': annual,
      'median lifespan': meanLifeSpan,
      'first harvest expected': firstHarvestExpected,
      'last harvest expected': lastHarvestExpected,
      'height': height,
      'spread': spread,
      'row Spacing': rowSpacing,
      'imageURL': imageURL,
    };
  }
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