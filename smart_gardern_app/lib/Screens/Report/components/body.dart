import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Screens/Report/components/search_bar.dart';
import 'package:smart_gardern_app/Screens/Report/components/data.dart';
import '../components/top_bar.dart';

class Body extends StatelessWidget {
  // List userProfilesList = [];

  // String userID = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TopBar(
            childrens: <Widget>[
              SearchBar(),
            ],
          ),
          Container(
            child: Data(),
          ),
        ],
      ),
    );
  }
}
