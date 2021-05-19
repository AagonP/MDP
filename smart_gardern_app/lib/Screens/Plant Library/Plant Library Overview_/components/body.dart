import 'package:flutter/material.dart';
import 'explore_bar.dart';
import 'plant_category_bar.dart';
import '../components/top_bar.dart';

import '../../../../components/header_text.dart';
import 'search_bar.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            TopBar(
              childrens: <Widget>[
                SearchBar(),
              ],
            ),
            HeaderText(
              text: 'Plant Category',
              alignment: Alignment.centerLeft,
            ),
            PlantCategoryBar(),
            HeaderText(
              text: 'Explore',
              alignment: Alignment.centerLeft,
            ),
            ExploreBar(),
          ],
        ),
      ),
    );
  }
}
