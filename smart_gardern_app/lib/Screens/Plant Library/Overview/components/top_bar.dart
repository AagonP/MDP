import 'package:flutter/material.dart';
import '../../../../constant.dart';

class TopBar extends StatelessWidget {
  final childrens;
  const TopBar({
    Key? key,
    this.childrens,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding),
      child: Row(
        children: childrens,
      ),
    );
  }
}
