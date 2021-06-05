import 'package:flutter/material.dart';
import 'package:smart_gardern_app/Screens/Plant%20Library/SavedPlants/saved_plants.dart';
import 'package:smart_gardern_app/components/custtom_icon_button.dart';
import 'package:smart_gardern_app/constant.dart';

class ToolBar extends StatelessWidget {
  const ToolBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding),
        child: Row(
          children: [
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
            )
          ],
        ));
  }
}
