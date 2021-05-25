import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_gardern_app/Screens/Plant%20Library/SavedPlants/saved_plants.dart';

import '../../../../components/custtom_icon_button.dart';
import '../../../../constant.dart';
import '../../../../Models/plant.dart';
import 'background.dart';
import 'information_bar.dart';

class SavedBody extends StatelessWidget {
  final Plant selectedPlant;
  final index;

  const SavedBody({Key? key, required this.selectedPlant, this.index})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final removeSnackBar = SnackBar(
      content: Text('Saved plant removed!'),
      duration: Duration(seconds: 1),
    );
    return BackGround(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${selectedPlant.commonName}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                CustomIconButton(
                  onPressed: () {
                    // TODO: Refactor this function
                    Provider.of<SavedPlantModel>(context, listen: false)
                        .remove(index);
                    ScaffoldMessenger.of(context).showSnackBar(removeSnackBar);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SavedPlantScreen();
                        },
                      ),
                    );
                  },
                  icon: Icons.delete,
                ),
              ],
            ),
          ),
          Text(
            "${selectedPlant.familyName}",
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
          ),
          InformationBar(selectedPlant: selectedPlant),
          Text(
            "Description",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 10),
          ),
          Container(
            height: size.height * 0.7 * 0.5,
            child: SingleChildScrollView(
              child: Text(
                "${selectedPlant.description}",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
