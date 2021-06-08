import 'package:flutter/material.dart';

import 'components/body.dart';

class PlantCategoryScreen extends StatelessWidget {
  final genus;

  const PlantCategoryScreen({Key? key, this.genus}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Body(genus: genus),
      ),
    );
  }
}
