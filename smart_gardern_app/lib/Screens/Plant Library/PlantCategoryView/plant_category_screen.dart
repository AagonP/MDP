import 'package:flutter/material.dart';

import 'components/body.dart';

class PlantCategoryScreen extends StatelessWidget {
  final familyName;

  const PlantCategoryScreen({Key? key, this.familyName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Body(),
      ),
    );
  }
}
