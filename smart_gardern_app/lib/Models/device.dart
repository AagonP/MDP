import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class Device extends ChangeNotifier {
  String id = "";
  String name = "";
  String data = "";
  String unit = "";

  Device();
  void update(String id, String name, String data, String unit) {
    this.id = id;
    this.name = name;
    this.data = data;
    this.unit = unit;
    notifyListeners();
  }
}

class DeviceModel extends ChangeNotifier {
  final List<Device> _devices = [];
  void add(Device device) {
    _devices.add(device);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void removeAll() {
    _devices.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
