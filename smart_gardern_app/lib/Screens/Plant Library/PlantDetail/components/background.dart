import 'package:flutter/material.dart';

import '../../../../constant.dart';

class BackGround extends StatelessWidget {
  const BackGround({
    Key? key,
    required this.child,
  }) : super(key: key);

  final child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            child: Image.asset(
              "assets/images/plant_detail_view_background.jpg",
              width: size.width,
              height: size.height * 0.35,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: size.height * 0.3,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding),
              alignment: Alignment.center,
              child: child,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(29),
                  topRight: Radius.circular(29),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
