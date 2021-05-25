import 'package:flutter/material.dart';

class InformationTile extends StatelessWidget {
  const InformationTile({
    Key? key,
    this.text,
    this.value,
    this.icon,
    this.unit,
  }) : super(key: key);

  final text;
  final value;
  final icon;
  final unit;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: size.height * 0.7 * 0.3 * 0.2,
          ),
          Text('$text'),
          Text('$value $unit'),
        ],
      ),
    );
  }
}
