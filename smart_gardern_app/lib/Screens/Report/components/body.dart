import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Screens/Report/components/dropdown.dart';
import 'package:smart_gardern_app/Screens/Report/components/search_bar.dart';
import 'package:smart_gardern_app/Screens/Report/components/data.dart';
import '../components/top_bar.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          TopBar(
            childrens: <Widget>[
              SearchBar(),
            ],
          ),
          DropDown(),
          Data(),
        ],
      ),
    );
  }
}
