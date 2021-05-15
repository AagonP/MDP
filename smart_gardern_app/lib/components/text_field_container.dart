import 'package:flutter/material.dart';
import 'package:smart_gardern_app/constant.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.7,
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
