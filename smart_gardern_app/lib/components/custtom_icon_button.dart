import 'package:flutter/material.dart';

import '../constant.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    this.onPressed,
    this.icon,
  }) : super(key: key);
  final onPressed;
  final icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kPrimaryColor,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
