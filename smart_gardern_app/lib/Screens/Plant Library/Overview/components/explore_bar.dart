import 'package:flutter/material.dart';

import '../../../../constant.dart';

class ExploreBar extends StatefulWidget {
  const ExploreBar({
    Key? key,
  }) : super(key: key);

  @override
  _ExploreBarState createState() => _ExploreBarState();
}

class _ExploreBarState extends State<ExploreBar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding),
      height: size.height * 0.3,
      color: Colors.grey,
    );
  }
}
