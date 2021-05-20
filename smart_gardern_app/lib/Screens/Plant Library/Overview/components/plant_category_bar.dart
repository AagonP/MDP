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
              width: (size.width - 20 * 2) / 3,
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding / 2,
                  vertical: kDefaultPadding / 2),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(29),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      spreadRadius: 5,
                      blurRadius: 5,
                    )
                  ],
                ),
                child: Image(
                  image: AssetImage('assets/demo_images/aparicot.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              width: (size.width - 20 * 2) / 3,
              color: Colors.blue,
            ),
            Container(
              width: (size.width - 20 * 2) / 3,
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
