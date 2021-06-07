import 'package:flutter/foundation.dart';

class Device extends ChangeNotifier {
  String id = "";
  String name = "";
  String data = "";
  String unit = "";

  Device(String id, String name, String data, String unit) {
    this.id = id;
    this.name = name;
    this.data = data;
    this.unit = unit;
  }

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
  List<Device> get devices {
    return _devices;
  }

  void add(Device device) {
    _devices.add(device);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void update(Device newDevice) {
    if (_devices.length == 0) {
      print(newDevice.name);
      _devices.add(newDevice);
    } else {
      bool check = true;
      for (var i = 0; i < _devices.length; i++) {
        if (newDevice.id == _devices[i].id) {
          _devices[i] = newDevice;
          check = false;
          break;
        }
      }
      if (check) {
        _devices.add(newDevice);
      }
    }
    notifyListeners();
  }

  void removeAll() {
    _devices.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
