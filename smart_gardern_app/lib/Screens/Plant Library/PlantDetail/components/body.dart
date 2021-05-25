import 'package:flutter/material.dart';

import '../../../../components/custtom_icon_button.dart';
import '../../../../constant.dart';
import '../../../../Models/plant.dart';
import 'background.dart';
import 'information_bar.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  final Plant selectedPlant;

  const Body({Key? key, required this.selectedPlant}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final addSnackBar = SnackBar(
      content: Text('Plant saved!'),
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
                    Provider.of<SavedPlantModel>(context, listen: false)
                        .add(selectedPlant);
                    ScaffoldMessenger.of(context).showSnackBar(addSnackBar);
                  },
                  icon: Icons.bookmark,
                ),
                CustomIconButton(
                  onPressed: () {
                    print("Export pressed!");
                  },
                  icon: Icons.file_download,
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
