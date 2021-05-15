import 'package:flutter/material.dart';
import '../constant.dart';

class RoundedButton extends StatelessWidget {
  final String? text;
  final Function? press;
  final Color color, textColor;
  const RoundedButton({
    Key? key,
    this.text,
    this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      width: size.width * 0.7,
      child: TextButton(
        onPressed: press as void Function()?,
        child: Text(text!),
        style: TextButton.styleFrom(
          primary: textColor,
          backgroundColor: color,
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 40,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(29),
            ),
          ),
        ),
      ),
    );
  }
}
