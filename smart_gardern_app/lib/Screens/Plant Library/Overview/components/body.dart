import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_gardern_app/Screens/Plant%20Library/PlantIdentification/plant_identification_screen.dart';
import 'package:smart_gardern_app/Screens/Plant%20Library/SavedPlants/saved_plants.dart';
import 'package:smart_gardern_app/components/custtom_icon_button.dart';

import '../../../../constant.dart';
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
              children: <Widget>[
                SearchBar(),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5)),
                CustomIconButton(
                  icon: Icons.folder,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SavedPlantScreen();
                        },
                      ),
                    );
                  },
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5)),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kPrimaryColor,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return PlantIdentificationScreen();
                          },
                        ),
                      );
                    },
                    icon: SvgPicture.asset('assets/icons/plant_search.svg',
                        color: Colors.white),
                  ),
                )
              ],
            ),
            HeaderText(
              text: 'Category',
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
