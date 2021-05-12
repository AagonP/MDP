import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class User {
  final String name;
  final String email;
  final String address;
  final String phone;

  User(this.name, this.email, this.address, this.phone);
}
