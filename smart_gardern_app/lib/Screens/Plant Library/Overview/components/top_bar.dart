import 'package:flutter/material.dart';
import '../../../../constant.dart';

class TopBar extends StatelessWidget {
  final children;
  const TopBar({
    Key? key,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding),
      child: Row(
        children: children,
      ),
    );
  }
}
