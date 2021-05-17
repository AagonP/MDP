import 'package:flutter/material.dart';
import '../../../../constant.dart';

class PlantCategoryBar extends StatefulWidget {
  const PlantCategoryBar({
    Key? key,
  }) : super(key: key);

  @override
  _PlantCategoryBarState createState() => _PlantCategoryBarState();
}

class _PlantCategoryBarState extends State<PlantCategoryBar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding),
        height: size.height * 0.3,
        child: ListView(
          // Horizontoal scrolling
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              width: 160.0,
              color: Colors.red,
            ),
            Container(
              width: 160.0,
              color: Colors.blue,
            ),
            Container(
              width: 160.0,
              color: Colors.green,
            ),
            Container(
              width: 160.0,
              color: Colors.yellow,
            ),
            Container(
              width: 160.0,
              color: Colors.orange,
            ),
          ],
        ));
  }
}
