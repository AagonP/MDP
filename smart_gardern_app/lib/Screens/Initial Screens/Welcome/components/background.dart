import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            child: Image.asset(
              "assets/images/plant_bg.jpeg",
              width: size.width,
              height: size.height,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            child: Container(
              width: 0.8 * size.width,
              height: 0.8 * size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(29),
              ),
            ),
          ),
          Positioned(child: child)
        ],
      ),
    );
  }
}
